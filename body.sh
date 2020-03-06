#!/bin/bash

if [ .$THU_ID = . ]
then
	source info.txt
fi

cat body.json \
	| sed "s/THU_ID/$THU_ID/g" \
	| sed "s/RB_DPT_ID/$RB_DPT_ID/g" \
	| sed "s/RB_DPT_NAME/$RB_DPT_NAME/g" \
	| sed "s/RB_CHN_NAME/$RB_CHN_NAME/g" \
	| sed "s/RB_PROVINCE/$RB_PROVINCE/g" \
	| sed "s/RB_CITY/$RB_CITY/g" \
	| sed "s/RB_DISTRICT/$RB_DISTRICT/g" \
	| sed "s/RB_ADDR/$RB_ADDR/g" \
	>tmp/body.json
