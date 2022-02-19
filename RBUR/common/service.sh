#!/system/bin/sh
# 不要假设您的模块将位于何处。
# 如果您需要知道此脚本和模块的放置位置，请使用$MODDIR
# 这将确保您的模块仍能正常工作
# 即使Magisk将来更改其挂载点
MODDIR=${0%/*}

# 此脚本将在late_start service 模式执行
sleep 5
if [[ ! -d ${MODDIR}/UWillno ]]; then
mkdir ${MODDIR}/UWillno
dd if=/dev/block/by-name/recovery of=${MODDIR}/UWillno/recovery.img
echo $(getprop ro.system.build.date) > ${MODDIR}/UWillno/flag.txt
else
old=$(cat ${MODDIR}/UWillno/flag.txt)
new=$(getprop ro.system.build.date)
if [[ "$old" != "$new" ]];then
dd if=${MODDIR}/UWillno/recovery.img of=/dev/block/by-name/recovery
echo $new > ${MODDIR}/UWillno/flag.txt
fi
fi

