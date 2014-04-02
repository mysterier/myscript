<!-- #!/usr/local/bin/php -->
<?php
        /**
         * @lqf
         * 
         * 对每个提问回答匹配用户，判断是否有头像，没有头像补充头像
         * 
         * 
         * 
         */
		date_default_timezone_set('Asia/Shanghai');
        require_once (realpath( dirname(__FILE__) .'/../config/db_master_config.inc.php'));
        $link = mysql_connect(DB_HOST,DB_USER,DB_PWD);        
        mysql_select_db('dxl_info');
        mysql_query('set names utf8');        
        
        //获取默认头像库
        $from_dir = dirname(__FILE__) ."/userphoto/"; //当前目录  
        $img_root = '/NFS/daoxila/v1/upload/user/avatar/';
        //$img_root = 'E:/upload/';
        $root_dir = array(
            'large'     => $img_root.'large/'.date('Y-m').'/',
            'medium'    => $img_root.'medium/'.date('Y-m').'/',
            'small'     => $img_root.'small/'.date('Y-m').'/',
            'tiny'      => $img_root.'tiny/'.date('Y-m').'/',
            'original'  => $img_root.'original/'.date('Y-m').'/',
        );

        foreach ($root_dir as $v) {
            if (!file_exists($v)) {                
                mkdir("$v", 0700);  
            }
        }

        $avatar_name = time();

        $avatar_list = array();
        $list = scandir($from_dir); // 得到该文件下的所有文件和文件夹
        foreach($list as $file){//遍历             
            if (strpos($file, 'jpg') > 0 || strpos($file, 'jpeg') > 0) {                
                $avatar_list[] = $from_dir.$file;
            }
        }

        //获取用户
        $user_sql = "SELECT
						id,
						avatar_id
					FROM
						".DB_NAME.".ex_user
					WHERE
						dateline < UNIX_TIMESTAMP('2012-12-30')
					AND `name` != ''
					ORDER BY
						avatar_id DESC";
        $fetch_user = mysql_query($user_sql);
        $users = array();
        while ($rows = mysql_fetch_assoc($fetch_user)) {
        	$users[] = $rows;
        }
        //获取问题
        //ex_question表中已有的user_id
        $userIds = getUserId('ex_question');
        $question_sql = "SELECT id FROM ex_question WHERE user_id = 0";
        $fetch_question = mysql_query($question_sql);
        while ($rows = mysql_fetch_assoc($fetch_question)) {
        	//避免user_id在ex_question表中重复
        	while($user = array_shift($users)) {
        		if (!in_array($user['id'], $userIds))
        			break;
        	}
        	updateById('ex_question', $user['id'], $rows['id']);
        	if (!$user['avatar_id'])
        		addAvatar($user['id']);
        }

        //获取回答
        //ex_question_ext表中已有的user_id
        $userIds = getUserId('ex_question_ext');
        $answer_sql = "SELECT id FROM ex_question_ext WHERE user_id = 0";
        $fetch_answer = mysql_query($answer_sql);
		while ($rows = mysql_fetch_assoc($fetch_answer)) {
			//避免user_id在ex_question_ext表中重复
			while($user = array_shift($users)) {
        		if (!in_array($user['id'], $userIds))
        			break;
        	}
        	updateById('ex_question_ext', $user['id'], $rows['id']);
        	if (!$user['avatar_id'])
        		addAvatar($user['id']);
        }
        
        //获取问题/回答的user_id
        function getUserId($tableName) {
        	$sql = "SELECT user_id FROM $tableName WHERE user_id !=0";
        	$fetch = mysql_query($sql);
        	$user_id = array();
        	while ($rows = mysql_fetch_assoc($fetch)) {
        		$user_id[] = $rows['user_id'];
        	}
        	return $user_id;
        }
        
        function updateById($table, $user_id, $id) {
        	$sql = "UPDATE $table SET user_id=$user_id WHERE id=$id";
        	mysql_query($sql);
        }
        
        function addAvatar($user_id) {
            Global $avatar_list;
            Global $avatar_name;
            Global $img_root;
            $avatar_name++;            

            $count = count($avatar_list);
            $avatar_rand = intval(rand(0, $count - 1));
            $avatar_path = $avatar_list[$avatar_rand];            
            $im = @imagecreatefromjpeg($avatar_path);

            $new_name = date('Y-m').'/'.date('Ymd').$avatar_name;
            
            resizeImage($im, 180, 180, $img_root.'original/'.$new_name, '.jpg');
            resizeImage($im, 180, 180, $img_root.'large/'.$new_name, '.jpg');
            resizeImage($im, 110, 110, $img_root.'medium/'.$new_name, '.jpg');
            resizeImage($im, 50, 50, $img_root.'small/'.$new_name, '.jpg');
            resizeImage($im, 30, 30, $img_root.'tiny/'.$new_name, '.jpg');

            $insert_sql = "INSERT INTO ".DB_NAME.".ex_user_image(user_id, class, `path`, comment, dateline) VALUES($user_id, '0', '".$new_name.".jpg', '自动生成', ".time().")";
            mysql_query($insert_sql);

            $update_sql = "UPDATE ".DB_NAME.".ex_user SET avatar_id=".mysql_insert_id()." WHERE id=$user_id";
            mysql_query($update_sql);
        }        



        function resizeImage($im,$maxwidth,$maxheight,$name,$filetype)
        {
            $pic_width = imagesx($im);
            $pic_height = imagesy($im);

            if(($maxwidth && $pic_width > $maxwidth) || ($maxheight && $pic_height > $maxheight))
            {
                if($maxwidth && $pic_width>$maxwidth)
                {
                    $widthratio = $maxwidth/$pic_width;
                    $resizewidth_tag = true;
                }

                if($maxheight && $pic_height>$maxheight)
                {
                    $heightratio = $maxheight/$pic_height;
                    $resizeheight_tag = true;
                }

                if($resizewidth_tag && $resizeheight_tag)
                {
                    if($widthratio<$heightratio)
                        $ratio = $widthratio;
                    else
                        $ratio = $heightratio;
                }

                if($resizewidth_tag && !$resizeheight_tag)
                    $ratio = $widthratio;
                if($resizeheight_tag && !$resizewidth_tag)
                    $ratio = $heightratio;

                $newwidth = $pic_width * $ratio;
                $newheight = $pic_height * $ratio;

                if(function_exists("imagecopyresampled"))
                {
                    $newim = imagecreatetruecolor($newwidth,$newheight);
                   imagecopyresampled($newim,$im,0,0,0,0,$newwidth,$newheight,$pic_width,$pic_height);
                }
                else
                {
                    $newim = imagecreate($newwidth,$newheight);
                   imagecopyresized($newim,$im,0,0,0,0,$newwidth,$newheight,$pic_width,$pic_height);
                }

                $name = $name.$filetype;
                imagejpeg($newim,$name);
                imagedestroy($newim);
            }
            else
            {
                $name = $name.$filetype;
                imagejpeg($im,$name);
            } 
        }      

?>