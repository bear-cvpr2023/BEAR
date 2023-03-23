CKPT=$1
MODE=$2

for DATA in mini_sports1m mini_hacs coin xd_violence wlasl mod20 meccano inhard petraw misaw uav_human mpii_cooking toyota_smarthome fine_gym charades_ego muvim jester ucf_crime
do
	for SHOT in 2 4 8 16
	do
		bash tools/dist_train.sh configs/datasets/$DATA/swin_base_patch244_window877_8x16_$DATA.py 8  \ 
        --validate \ 
        --cfg-options load_from=$CKPT \ 
                      data_root=data/$DATA/frames/ \ 
                      data_root_val=data/$DATA/frames/ \  
                      data.train.ann_file=data/${DATA}/annotations/train_${SHOT}.csv  \ 
                      data.train.data_prefix=data/$DATA/frames/  \ 
                      data.val.data_prefix=data/$DATA/frames/  \ 
                      data.test.data_prefix=data/$DATA/frames/  \ 
                      work_dir=/home/ubuntu/data16T/ssl_fewshot_work_dirs/swin/${SHOT}shot/${DATA}_8frame/  \ 
                      log_config.interval=2 \ 
                      checkpoint_config.interval=5 \ 
	done
done