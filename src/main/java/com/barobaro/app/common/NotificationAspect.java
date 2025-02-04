package com.barobaro.app.common;

import java.util.List;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.barobaro.app.service.KeywordService;
import com.barobaro.app.service.NotificationService;
import com.barobaro.app.vo.KeywordVO;
import com.barobaro.app.vo.NotificationVO;
import com.barobaro.app.vo.PostVO;

@Aspect
@Component
public class NotificationAspect {
	@Autowired
	private NotificationService notificationService;
	@Autowired
	private KeywordService keywordService;

	@AfterReturning(pointcut = "execution(* com.barobaro.app.service.PostService.createPost(..)) && args(post)")
	public void sendKeywordNotification(PostVO post) {
		String postContent = post.getItemContent();
		System.out.println("postContent: " + postContent);
		List<KeywordVO> keywordList = keywordService.getKeywordsByUserSeq(1001);
		System.out.println("keywordList: " + keywordList);
		for(KeywordVO kvo : keywordList) {
			// 게시글에 키워드가 포함되어 있으면
			if(postContent.contains(kvo.getContents())) {
				NotificationVO notification = new NotificationVO();
				// 키워드 설정한 사용자에게 알림
				notification.setUserSeq(kvo.getUserSeq());
				notification.setTitle("관심 키워드 알림");
				notification.setContents("'" + kvo.getContents() + "' 키워드가 포함된 게시글이 등록되었습니다.");
				
				System.out.print("----------" + notification);
				notificationService.sendNotification(notification);
			}
		}
	}
}
