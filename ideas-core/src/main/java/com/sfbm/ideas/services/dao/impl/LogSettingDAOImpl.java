package com.sfbm.ideas.services.dao.impl;

import com.sfbm.ideas.core.dao.BaseDAO;
import com.sfbm.ideas.services.common.LogSetting;
import com.sfbm.ideas.services.dao.LogSettingDAO;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/08/10.
 */
@Repository(value = "logSettingDAO")
public class LogSettingDAOImpl extends BaseDAO implements LogSettingDAO {
    @Override
    public LogSetting queryLogSettingByLogId(long logId) throws Exception {
        return getSqlSession().selectOne("LogSetting.queryLogSettingByLogId", logId);
    }

    @Override
    public List<LogSetting> queryLogSettingListByCondition(Map<String, Object> condition) throws Exception {
        return getSqlSession().selectList("LogSetting.queryLogSettingList", condition);
    }

    @Override
    public List<LogSetting> queryLogSettingList(String tableName) throws Exception {
        Map<String, Object> condition = new HashMap<String, Object>();

        condition.put("tableName", tableName);

        return this.queryLogSettingListByCondition(condition);
    }

    @Override
    public List<LogSetting> queryLogSettingList(String tableName, String businessName) throws Exception {
        Map<String, Object> condition = new HashMap<String, Object>();

        condition.put("tableName", tableName);
        condition.put("businessName", businessName);

        return this.queryLogSettingListByCondition(condition);
    }
}
