/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of Qt Creator.
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://www.qt.io/licensing.  For further information
** use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file.  Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
****************************************************************************/

#include "qmlprofilerrangemodel.h"
#include "qmlprofilermodelmanager.h"
#include "qmlprofilerdatamodel.h"

#include <QCoreApplication>
#include <QVector>
#include <QHash>
#include <QUrl>
#include <QString>
#include <QStack>

#include <QDebug>

namespace QmlProfiler {
namespace Internal {


QmlProfilerRangeModel::QmlProfilerRangeModel(QmlProfilerModelManager *manager,
                                             QmlDebug::RangeType range, QObject *parent)
    : AbstractTimelineModel(manager, categoryLabel(range), QmlDebug::MaximumMessage, range, parent)
{
    m_expandedRowTypes << -1;
    announceFeatures(1ULL << QmlDebug::featureFromRangeType(rangeType()));
}

void QmlProfilerRangeModel::clear()
{
    m_expandedRowTypes.clear();
    m_expandedRowTypes << -1;
    m_data.clear();
    AbstractTimelineModel::clear();
}

void QmlProfilerRangeModel::loadData()
{
    clear();
    QmlProfilerDataModel *simpleModel = modelManager()->qmlModel();
    if (simpleModel->isEmpty())
        return;

    // collect events
    const QVector<QmlProfilerDataModel::QmlEventData> &eventList = simpleModel->getEvents();
    const QVector<QmlProfilerDataModel::QmlEventTypeData> &typesList = simpleModel->getEventTypes();
    foreach (const QmlProfilerDataModel::QmlEventData &event, eventList) {
        const QmlProfilerDataModel::QmlEventTypeData &type = typesList[event.typeIndex];
        if (!accepted(type))
            continue;

        // store starttime-based instance
        m_data.insert(insert(event.startTime, event.duration, event.typeIndex),
                      QmlRangeEventStartInstance());
        updateProgress(count(), eventList.count() * 6);
    }

    updateProgress(2, 6);

    // compute range nesting
    computeNesting();

    // compute nestingLevel - nonexpanded
    computeNestingContracted();

    updateProgress(3, 6);

    // compute nestingLevel - expanded
    computeExpandedLevels();

    updateProgress(4, 6);

    findBindingLoops();

    updateProgress(5, 6);

    updateProgress(1, 1);
}

void QmlProfilerRangeModel::computeNestingContracted()
{
    int i;
    int eventCount = count();

    int nestingLevels = QmlDebug::Constants::QML_MIN_LEVEL;
    int collapsedRowCount = nestingLevels + 1;
    QVector<qint64> nestingEndTimes;
    nestingEndTimes.fill(0, nestingLevels + 1);

    for (i = 0; i < eventCount; i++) {
        qint64 st = startTime(i);

        // per type
        if (nestingEndTimes[nestingLevels] > st) {
            if (++nestingLevels == nestingEndTimes.size())
                nestingEndTimes << 0;
            if (nestingLevels == collapsedRowCount)
                ++collapsedRowCount;
        } else {
            while (nestingLevels > QmlDebug::Constants::QML_MIN_LEVEL &&
                   nestingEndTimes[nestingLevels-1] <= st)
                nestingLevels--;
        }
        nestingEndTimes[nestingLevels] = st + duration(i);

        m_data[i].displayRowCollapsed = nestingLevels;
    }
    setCollapsedRowCount(collapsedRowCount);
}

void QmlProfilerRangeModel::computeExpandedLevels()
{
    QHash<int, int> eventRow;
    int eventCount = count();
    for (int i = 0; i < eventCount; i++) {
        int eventTypeId = typeId(i);
        if (!eventRow.contains(eventTypeId)) {
            eventRow[eventTypeId] = m_expandedRowTypes.size();
            m_expandedRowTypes << eventTypeId;
        }
        m_data[i].displayRowExpanded = eventRow[eventTypeId];
    }
    setExpandedRowCount(m_expandedRowTypes.size());
}

void QmlProfilerRangeModel::findBindingLoops()
{
    if (rangeType() != QmlDebug::Binding && rangeType() != QmlDebug::HandlingSignal)
        return;

    typedef QPair<int, int> CallStackEntry;
    QStack<CallStackEntry> callStack;

    for (int i = 0; i < count(); ++i) {
        int potentialParent = callStack.isEmpty() ? -1 : callStack.top().second;

        while (potentialParent != -1 && !(endTime(potentialParent) > startTime(i))) {
            callStack.pop();
            potentialParent = callStack.isEmpty() ? -1 : callStack.top().second;
        }

        // check whether event is already in stack
        for (int ii = 0; ii < callStack.size(); ++ii) {
            if (callStack.at(ii).first == typeId(i)) {
                m_data[i].bindingLoopHead = callStack.at(ii).second;
                break;
            }
        }

        CallStackEntry newEntry(typeId(i), i);
        callStack.push(newEntry);
    }

}

/////////////////// QML interface

QString QmlProfilerRangeModel::categoryLabel(QmlDebug::RangeType rangeType)
{
    return QCoreApplication::translate("MainView",
            QmlProfilerModelManager::featureName(QmlDebug::featureFromRangeType(rangeType)));
}

int QmlProfilerRangeModel::row(int index) const
{
    if (expanded())
        return m_data[index].displayRowExpanded;
    else
        return m_data[index].displayRowCollapsed;
}

int QmlProfilerRangeModel::bindingLoopDest(int index) const
{
    return m_data[index].bindingLoopHead;
}

QColor QmlProfilerRangeModel::color(int index) const
{
    return colorBySelectionId(index);
}

QVariantList QmlProfilerRangeModel::labels() const
{
    QVariantList result;

    if (expanded() && !hidden()) {
        const QVector<QmlProfilerDataModel::QmlEventTypeData> &types =
                modelManager()->qmlModel()->getEventTypes();
        for (int i = 1; i < expandedRowCount(); i++) { // Ignore the -1 for the first row
            QVariantMap element;
            int typeId = m_expandedRowTypes[i];
            element.insert(QLatin1String("displayName"), QVariant(types[typeId].displayName));
            element.insert(QLatin1String("description"), QVariant(types[typeId].data));
            element.insert(QLatin1String("id"), QVariant(typeId));
            result << element;
        }
    }

    return result;
}

QVariantMap QmlProfilerRangeModel::details(int index) const
{
    QVariantMap result;
    int id = selectionId(index);
    const QVector<QmlProfilerDataModel::QmlEventTypeData> &types =
            modelManager()->qmlModel()->getEventTypes();

    result.insert(QStringLiteral("displayName"), categoryLabel(rangeType()));
    result.insert(tr("Duration"), QmlProfilerBaseModel::formatTime(duration(index)));

    result.insert(tr("Details"), types[id].data);
    result.insert(tr("Location"), types[id].displayName);
    return result;
}

QVariantMap QmlProfilerRangeModel::location(int index) const
{
    QVariantMap result;
    int id = selectionId(index);

    const QmlDebug::QmlEventLocation &location
            = modelManager()->qmlModel()->getEventTypes().at(id).location;

    result.insert(QStringLiteral("file"), location.filename);
    result.insert(QStringLiteral("line"), location.line);
    result.insert(QStringLiteral("column"), location.column);

    return result;
}

int QmlProfilerRangeModel::typeId(int index) const
{
    return selectionId(index);
}

int QmlProfilerRangeModel::selectionIdForLocation(const QString &filename, int line, int column) const
{
    // if this is called from v8 view, we don't have the column number, it will be -1
    const QVector<QmlProfilerDataModel::QmlEventTypeData> &types =
            modelManager()->qmlModel()->getEventTypes();
    for (int i = 1; i < expandedRowCount(); ++i) {
        int typeId = m_expandedRowTypes[i];
        const QmlProfilerDataModel::QmlEventTypeData &eventData = types[typeId];
        if (eventData.location.filename == filename &&
                eventData.location.line == line &&
                (column == -1 || eventData.location.column == column))
            return typeId;
    }
    return -1;
}



}
}
