package com.sfbm.ideas.services.front.user.dao.impl;

import com.sfbm.ideas.core.dao.BaseDAO;
import com.sfbm.ideas.services.common.UserCoreInfo;
import com.sfbm.ideas.services.front.user.dao.UserCoreInfoDAO;
import org.springframework.stereotype.Repository;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
@Repository(value = "userCoreInfoDAO")
public class UserCoreInfoDAOImpl extends BaseDAO implements UserCoreInfoDAO {
    @Override
    public void insertUserCoreInfo(UserCoreInfo userCoreInfo) throws Exception {
        getSqlSession().insert("UserCoreInfo.insertUserCoreInfo", userCoreInfo);
    }

    @Override
    public void updateUserCoreInfo(UserCoreInfo userCoreInfo) throws Exception {
        getSqlSession().update("UserCoreInfo.updateUserCoreInfo", userCoreInfo);
    }

    @Override
    public UserCoreInfo queryUserCoreInfoByUserId(long userId) throws Exception {
        return getSqlSession().selectOne("UserCoreInfo.queryUserCoreInfoByUserId", userId);
    }

    @Override
    public UserCoreInfo queryUserCoreInfoByEmail(String email) throws Exception {
        return getSqlSession().selectOne("UserCoreInfo.queryUserCoreInfoByEmail", email);
    }

    @Override
    public UserCoreInfo queryUserCoreInfoByMobile(long mobile) throws Exception {
        return getSqlSession().selectOne("UserCoreInfo.queryUserCoreInfoByMobile", mobile);
    }

    @Override
    public int queryCountUserCoreInfoByEmail(String email) throws Exception {
        return getSqlSession().selectOne("UserCoreInfo.queryCountUserCoreInfoByEmail", email);
    }

    @Override
    public int queryCountUserCoreInfoByMobile(long mobile) throws Exception {
        return getSqlSession().selectOne("UserCoreInfo.queryCountUserCoreInfoByMobile", mobile);
    }
}
