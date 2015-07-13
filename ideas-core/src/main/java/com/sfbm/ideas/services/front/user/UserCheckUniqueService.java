package com.sfbm.ideas.services.front.user;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/07/10.
 */
public interface UserCheckUniqueService {

    public boolean checkUserIsUniqueByEmail(String email) throws Exception;
}
