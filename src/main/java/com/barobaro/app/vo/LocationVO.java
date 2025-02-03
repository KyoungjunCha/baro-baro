package com.barobaro.app.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocationVO {
    private Double latitude;		//위도
    private Double longitude;		//경도
}
