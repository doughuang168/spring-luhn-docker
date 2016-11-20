package com.doughuang168.creditcard;


public class Response {
    private final long id;
    private final String status;
    private final String message;
    private final String result;

    public Response(long id, String status, String message, String result) {
        this.id = id;
        this.status = status;
        this.message = message;
        this.result = result;
    }

    public long getId() {
        return id;
    }

    public String getStatus() {
        return status;
    }

    public String getMessage() {
        return message;
    }

    public String getResult() {
        return result;
    }
}