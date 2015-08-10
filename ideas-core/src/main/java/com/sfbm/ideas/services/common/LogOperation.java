package com.sfbm.ideas.services.common;

import java.io.Serializable;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/08/04.
 */
public class LogOperation implements Serializable {
    private long id;
    private long logId;
    private int operationType;
    private long primaryKeyValue;
    private String content;
    private String url;
    private long createUser;
    private String createTime;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getLogId() {
        return logId;
    }

    public void setLogId(long logId) {
        this.logId = logId;
    }

    public int getOperationType() {
        return operationType;
    }

    public void setOperationType(int operationType) {
        this.operationType = operationType;
    }

    public long getPrimaryKeyValue() {
        return primaryKeyValue;
    }

    public void setPrimaryKeyValue(long primaryKeyValue) {
        this.primaryKeyValue = primaryKeyValue;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
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
}
