#!/bin/bash

source info.txt

VERBOSE_MODE=-q

mkdir -p tmp

curl $VERBOSE_MODE -c tmp/0.cookie -L http://os.tsinghua.edu.cn > tmp/0.html

if [ $? != 0 ]
then
	echo "Network gg"
	exit
fi

curl $VERBOSE_MODE -L -X POST \
	--data-urlencode "i_user=$THU_ID" \
	--data-urlencode "i_pass=$THU_PASSWD" \
	--data-urlencode 'i_captcha=' \
	-b tmp/0.cookie -c tmp/1.cookie \
	https://id.tsinghua.edu.cn/do/off/ui/auth/login/check > tmp/1.html

if [ $? != 0 ]
then
	echo "Login incorrect"
	exit
fi

	
NEXT_LINK=$(cat tmp/1.html | grep window | cut -d '"' -f 2)

if [ .$NEXT_LINK = . ]
then
	echo "Login failed"
	exit
fi

echo $NEXT_LINK

curl $VERBOSE_MODE -L \
	-b tmp/1.cookie -c tmp/2.cookie \
	$NEXT_LINK > tmp/2.html

if [ $? != 0 ]
then
	echo "Failed to jump to " $NEXT_LINK
	exit
fi


./body.sh

curl $VERBOSE_MODE -L -X POST \
	-b tmp/2.cookie -c tmp/3.cookie \
	--data "@./tmp/body.json" \
	-H "Content-Type: text/plain;charset=UTF-8" \
 	'https://thos.tsinghua.edu.cn/fp/formParser?status=update&formid=00b70379-9ac6-4983-b34c-453d600c&workflowAction=startProcess&workitemid=&process=b9ac0715-58e3-4a03-a984-e13d720b65e8' >  tmp/4.html

if [ $? != 0 ]
then
	echo "Failed to upload the form"
else
	echo "Success"
fi

