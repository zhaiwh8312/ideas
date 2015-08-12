package com.sfbm.ideas.services.dao;

import com.sfbm.ideas.services.common.LogSetting;

import java.util.List;
import java.util.Map;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/08/10.
 */
public interface LogSettingDAO {
    public LogSetting queryLogSettingByLogId(long logId) throws Exception;

    public List<LogSetting> queryLogSettingListByCondition(Map<String ,Object> condition) throws Exception;

    public List<LogSetting> queryLogSettingList(String tableName) throws Exception;

    public List<LogSetting> queryLogSettingList(String tableName, String businessName) throws Exception;
}
