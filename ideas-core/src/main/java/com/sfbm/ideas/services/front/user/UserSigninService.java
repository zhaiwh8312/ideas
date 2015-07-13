package com.sfbm.ideas.services.front.user;

import com.sfbm.ideas.services.common.UserCoreInfo;

/**
 * 用户登录
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/13.
 */
public interface UserSigninService {

    public UserCoreInfo signin(String email, String password) throws Exception;
}
