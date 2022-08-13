

# 데이터 요약

# 1.2 연속형 변수 요약

# ------------------------------------------------------------------------------

# 데이터
library(MASS)
str(survey)

# 요약 통계량 함수는 데이터에 결측값(NA)이 포함되어 있으면  NA를 반환
# -> na.rm=T 인수를 지정하여 NA제외

# median(): 중위값
median(survey$Pulse,na.rm = T)

# quantile(데이터,probs=0.05): 백분위수(관측값의 5%보다는 크고 95%보다는 작은 수)
quantile(survey$Pulse, probs=0.05, na.rm=T)
quantile(survey$Pulse, probs=0.5, na.rm=T) # 중위값
quantile(survey$Pulse, probs=c(0.05,0.95), na.rm=T)

# 0, 25, 50,75 100 % 값
quantile(survey$Pulse, na.rm=T)

# 전체의 몇 %가 80이하의 맥박수를 갖는지
mean(survey$Pulse<=80,na.rm = T)

# mean > median -> 오른쪽으로 긴 꼬리
mean(survey$Pulse,na.rm=T)
median(survey$Pulse,na.rm=T)

# ==============================================================================
page16
# summary()

















# ------------------------------------------------------------------------------
# ==============================================================================































