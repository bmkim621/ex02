package com.yi.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component	//bean 객체로 등록하기 위한 annotation -> rootcontext에 등록해야 함.
@Aspect		//advice 클래스임을 의미하는 annotation
public class SampleAdvice {
	private static final Logger logger = LoggerFactory.getLogger(SampleAdvice.class);
	
	@Before("execution(* com.yi.service.MessageServiceImpl.addMessage(..))")
	public void startLog() {
		logger.info("==========================================");
		logger.info("[START LOG]");
		logger.info("==========================================");
	}
	
	@Around("execution(* com.yi.service.MessageServiceImpl.readMessage(..))")
	public Object timeLog(ProceedingJoinPoint pjp) throws Throwable {
		long startTime = System.currentTimeMillis();
		logger.info("==========================================");
		logger.info("[timeLog] START 시간 : " + startTime);
		logger.info("==========================================");
		
		//readMessage 함수의 실행시간을 알기 위해 test함.
		Object result = pjp.proceed();	//tartget 메서드(여기서는 readMessage)를 실행한다.
		
		long endTime = System.currentTimeMillis();
		logger.info("==========================================");
		logger.info("[timeLog] END 시간 : " + endTime);
		logger.info("[timeLog] 걸린 시간 : " + (endTime - startTime));
		logger.info("==========================================");
		
		return result;
		
	}
}
