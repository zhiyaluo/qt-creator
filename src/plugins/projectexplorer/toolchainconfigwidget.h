/**************************************************************************
**
** This file is part of Qt Creator
**
** Copyright (c) 2012 Nokia Corporation and/or its subsidiary(-ies).
**
** Contact: http://www.qt-project.org/
**
**
** GNU Lesser General Public License Usage
**
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this file.
** Please review the following information to ensure the GNU Lesser General
** Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** Other Usage
**
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**************************************************************************/

#ifndef TOOLCHAINCONFIGWIDGET_H
#define TOOLCHAINCONFIGWIDGET_H

#include "projectexplorer_export.h"

#include <utils/fileutils.h>

#include <QWidget>

QT_BEGIN_NAMESPACE
class QFormLayout;
class QGridLayout;
class QLineEdit;
class QLabel;
QT_END_NAMESPACE

namespace ProjectExplorer {

class ToolChain;

// --------------------------------------------------------------------------
// ToolChainConfigWidget
// --------------------------------------------------------------------------

class PROJECTEXPLORER_EXPORT ToolChainConfigWidget : public QWidget
{
    Q_OBJECT

public:
    ToolChainConfigWidget(ProjectExplorer::ToolChain *);

    ProjectExplorer::ToolChain *toolChain() const;

    void apply();
    void discard();
    bool isDirty() const;
    void makeReadOnly();

signals:
    void dirty();

protected slots:
    void setErrorMessage(const QString &);
    void clearErrorMessage();

protected:
    virtual void applyImpl() = 0;
    virtual void discardImpl() = 0;
    virtual bool isDirtyImpl() const = 0;
    virtual void makeReadOnlyImpl() = 0;

    void addErrorLabel();
    QFormLayout *m_mainLayout;
    QLineEdit *m_nameLineEdit;

private:
    ToolChain *m_toolChain;
    QLabel *m_errorLabel;
};

} // namespace ProjectExplorer

#endif // TOOLCHAINCONFIGWIDGET_H
