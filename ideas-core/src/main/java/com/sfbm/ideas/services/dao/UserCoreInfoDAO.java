package com.sfbm.ideas.services.dao;

import com.sfbm.ideas.services.common.UserCoreInfo;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
public interface UserCoreInfoDAO {

    public void insertUserCoreInfo(UserCoreInfo userCoreInfo) throws Exception;

    public void updateUserCoreInfo(UserCoreInfo userCoreInfo) throws Exception;

    public UserCoreInfo queryUserCoreInfoByUserId(long userId) throws Exception;

    public UserCoreInfo queryUserCoreInfoByEmail(String email) throws Exception;

    public UserCoreInfo queryUserCoreInfoByMobile(long mobile) throws Exception;

    public int queryCountUserCoreInfoByEmail(String email) throws Exception;

    public int queryCountUserCoreInfoByMobile(long mobile) throws Exception;

}
