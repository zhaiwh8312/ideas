package com.sfbm.ideas.services.constant;

/**
 * 点子状态
 * @author zhaiwh
 *
 */
public enum NodeStatus {
	/**
	 * 删除
	 */
	DELETE {public String getName(){return "0";}},
    /**
     * 正常
     */
    NORMAL {public String getName(){return "1";}};
    
    public abstract String getName();
}
