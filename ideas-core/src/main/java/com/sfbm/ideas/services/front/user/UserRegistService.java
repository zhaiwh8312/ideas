package com.sfbm.ideas.services.front.user;

import com.sfbm.ideas.services.common.UserCoreInfo;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
public interface UserRegistService {

    public UserCoreInfo regist(String email, String password) throws Exception;
}
