package com.barobaro.app.common;

import java.util.UUID;

public class StateGenerator {
    public static String generateState() {
        // UUID를 사용하여 랜덤한 state 값 생성
        return UUID.randomUUID().toString();
    }
}

