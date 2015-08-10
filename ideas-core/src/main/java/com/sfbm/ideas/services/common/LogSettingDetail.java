package com.sfbm.ideas.services.common;

import java.io.Serializable;

/**
 * Copyright (c) 2015 ShiFenBianMin.Co.Ltd. All rights reserved.
 * Created by zhaiwenhao on 2015/08/04.
 */
public class LogSettingDetail implements Serializable {
    private long detailId;
    private long logId;
    private String columnName;
    private String columnText;
    private String columnDateType;
    private long createUser;
    private String createTime;

    public long getDetailId() {
        return detailId;
    }

    public void setDetailId(long detailId) {
        this.detailId = detailId;
    }

    public long getLogId() {
        return logId;
    }

    public void setLogId(long logId) {
        this.logId = logId;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnText() {
        return columnText;
    }

    public void setColumnText(String columnText) {
        this.columnText = columnText;
    }

    public String getColumnDateType() {
        return columnDateType;
    }

    public void setColumnDateType(String columnDateType) {
        this.columnDateType = columnDateType;
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
