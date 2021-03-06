/****************************************************************************
**
** Copyright 2011, 2012 Omar Lawand Dalatieh.
**
** This file is part of Droper.
**
** Droper is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** Droper is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with Droper.  If not, see <http://www.gnu.org/licenses/>.
**
** For more information, check out the GNU General Public license found
** in the COPYING file and the README file.
**
****************************************************************************/

// corresponding headers
#include "common.h"

// static shared data members
#include <QNetworkAccessManager>
#include "consumerdata.h"
#include "dropbox.h"
#include "dropoauth.h"
#include "userdata.h"

// static shared data members
QNetworkAccessManager *Common::networkAccessManager = new QNetworkAccessManager;
ConsumerData *Common::consumerData = new ConsumerData;
Dropbox *Common::dropbox = new Dropbox(1);  // 1 is the API version
DropboxOAuth *Common::oAuth = new DropboxOAuth;
UserData *Common::userData = new UserData;
