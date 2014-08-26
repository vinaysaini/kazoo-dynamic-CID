#!/bin/sh
##  The contents of this file are subject to the Mozilla Public License
##  Version 1.1 (the "License"); you may not use this file except in
##  compliance with the License. You may obtain a copy of the License
##  at http://www.mozilla.org/MPL/
##
##  Software distributed under the License is distributed on an "AS IS"
##  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
##  the License for the specific language governing rights and
##  limitations under the License.
##
##  The Original Code is RabbitMQ.
##
##  The Initial Developer of the Original Code is VMware, Inc.
##  Copyright (c) 2007-2012 VMware, Inc.  All rights reserved.
##

# Escape spaces and quotes, because shell is revolting.
for arg in "$@" ; do
  # Escape quotes in parameters, so that they're passed through cleanly.
  arg=$(sed -e 's/"/\\"/g' <<-END
	$arg
	END
  )
  CMDLINE="${CMDLINE} \"${arg}\""
done

cd /var/lib/rabbitmq

SCRIPT=`basename $0`

if [ `id -u` = 0 ] ; then
    su rabbitmq -s /bin/sh -c "/var/lib/rabbitmq/bin/${SCRIPT} ${CMDLINE}"
else
    /var/lib/rabbitmq/bin/${SCRIPT}
    echo
    echo "Only root or rabbitmq should run ${SCRIPT}"
    echo
    exit 1
fi
