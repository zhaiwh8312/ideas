package com.sfbm.ideas.services.common;

import java.io.Serializable;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/08/04.
 */
public class LogSetting implements Serializable {
    private long logId;
    private String tableName;
    private String primaryKey;
    private String urlTemplate;
    private long createUser;
    private String createTime;
    private String deleteScriptTemplate;
    private String updateScriptTemplate;
    private String insertScriptTemplate;

    public long getLogId() {
        return logId;
    }

    public void setLogId(long logId) {
        this.logId = logId;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getPrimaryKey() {
        return primaryKey;
    }

    public void setPrimaryKey(String primaryKey) {
        this.primaryKey = primaryKey;
    }

    public String getUrlTemplate() {
        return urlTemplate;
    }

    public void setUrlTemplate(String urlTemplate) {
        this.urlTemplate = urlTemplate;
    }

    public long getCreateUser() {
        return createUser;
    }

    public void setCreateUser(long createUser) {
        this.createUser = createUser;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getDeleteScriptTemplate() {
        return deleteScriptTemplate;
    }

    public void setDeleteScriptTemplate(String deleteScriptTemplate) {
        this.deleteScriptTemplate = deleteScriptTemplate;
    }

    public String getUpdateScriptTemplate() {
        return updateScriptTemplate;
    }

    public void setUpdateScriptTemplate(String updateScriptTemplate) {
        this.updateScriptTemplate = updateScriptTemplate;
    }

    public String getInsertScriptTemplate() {
        return insertScriptTemplate;
    }

    public void setInsertScriptTemplate(String insertScriptTemplate) {
        this.insertScriptTemplate = insertScriptTemplate;
    }
}
