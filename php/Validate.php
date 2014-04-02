<?php
/**
 * Util 验证类
 * @author luck.wang 
 * @date 2013.05.28
 */
class Dxl_Util_Validate {
	
	/**
	 * 验证E-mail的有效性
	 * @param string $email
	 * @return boolean
	 * @author luck.wang
	 * @date 2013.05.28
	 */
	public static function isEmail($email){
		if (empty($email)) {
			return false;
		}
		$regular = '/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/';
		if (!preg_match($regular,$email)) {
			return false;
		}
		if(!filter_var($email, FILTER_VALIDATE_EMAIL)){
			return false;
		}
		$email = explode('@', $email);
		//验证dns MX解析记录
		if (!checkdnsrr($email[1], 'MX')) {
			return false;
		}
		return true;
	}

	
	/**
	 * 验证手机号的格式
	 * @param string $mobile
	 * @return boolean
	 * @author luck.wang
	 * @date 2013.05.28
	 */
	public static function isMobile($mobile){
		return preg_match('/^1(3\d|47|5[^4]|8\d)\d{8}$/', $mobile);
	}
	
	/**
	 * 验证URl的有效性
	 * @param string $url
	 * @return boolean
	 * @author luck.wang
	 * @date 2013.05.28
	 */
	static function url($url){
		return filter_var($url, FILTER_VALIDATE_URL);
	}
}
