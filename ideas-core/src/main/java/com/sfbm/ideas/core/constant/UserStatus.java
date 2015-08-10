package com.sfbm.ideas.core.constant;

/**
 * 用户状态
 * @author zhaiwh
 *
 */
public enum UserStatus {
	/**
	 * 注销
	 */
	CANNEL {public String getName(){return "0";}},
    /**
     * 正常
     */
    ACTIVE {public String getName(){return "1";}};
    
    public abstract String getName();
}
