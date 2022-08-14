
# 데이터 요약

# 1.1 범주형 변수 요약

# ------------------------------------------------------------------------------

# 데이터
library(MASS)
str(survey)

# table() 범주형 변수의 번주별 출현빈도를 나타내는 요약표
table(survey$Smoke)
frqtab<-table(survey$Smoke)

# max() 최댓값 반환
max(frqtab)
max(frqtab)==frqtab
frqtab[max(frqtab)==frqtab]

# which.max() 최댓값의 인덱스 반환
which.max(frqtab)
frqtab[which.max(frqtab)]

names(frqtab[which.max(frqtab)])

# prop.table() 각 변수값에 대응되는 빈도에 대한 비율 출력
prop.table(frqtab)

# %로 환산
prop.table(frqtab)*100

# 'Never'이면 1 아니면 0을 반환해서 평균 -> 전체중의 Never 비율
mean(survey$Smoke=='Never',na.rm=T)

# ------------------------------------------------------------------------------

# 데이터
library(vcd)
str(Arthritis)

# 교차표01
# table(행변수,열변수)
table(Arthritis$Improved,Arthritis$Treatment)
crosstab<-table(Arthritis$Improved,Arthritis$Treatment)

crosstab['Marked','Treated']

# 교차표02
# xtabs(~행변수+열변수,data=데이터셋명)
xtabs(~Improved+Treatment,data=Arthritis)
crosstab<-xtabs(~Improved+Treatment,data=Arthritis)

# ==============================================================================

# 교차표의 행과 열에 대한 빈도합과 비율

# margin.table(교차표, margin=1): 빈도합
# margin=1:행방향합, 2:열방향합
margin.table(crosstab,margin=1)
margin.table(crosstab,margin=2)

# prop.table(교차표,1): 비율
# 1:행에대한 비율, 2: 열에대한 비율, 숫자x:각셀의 비율
prop.table(crosstab,1)
prop.table(crosstab,2)
prop.table(crosstab)

# addmargins(교차표,margin=1): 빈도합 교차표에 포함
# margin=1:행방향합, 2:열방향합, 숫자x:행/열 모든합
addmargins(crosstab,margin=1)
addmargins(crosstab)

addmargins(prop.table(crosstab))

# ==============================================================================

# 다양한 정보를 담고 있는 교차표

# gmodels패키지
library(gmodels)

# CrossTable()
# 기본적으로 행,열,셀의 비율이 함께 제공
# dnn인수에 행과 열의 이름 지정
CrossTable(Arthritis$Improved,Arthritis$Treatment,
           prop.chisq=F,dnn=c('Improved','Treatment'))

# ==============================================================================

# 다차원 테이블(Multidimensional Table): 범주형 변수가 세 개 이상 있을 때
# table(), xtabs() 모두 이용 가능

# 다차원 테이블
multtab<-with(Arthritis,table(Improved,Sex,Treatment))
multtab<-xtabs(~Improved+Sex+Treatment,data=Arthritis)
multtab

# ftable() 다차원 테이블을 보다 단순하고 보기 좋은 형태로 출력
ftable(multtab)

# row.vars=, col.vars= 인수로 행과 열에 배치되는 변수 변경
ftable(multtab,row.vars=c(2,3))

# ftable() 직접 테이블 생성
ftable(Arthritis[c('Improved','Sex','Treatment')], row.vars=c(2,3))

# margin.table() 3차원 확장, 숫자 각각 Improved, Sex, Treatment에 대응
multtab<-with(Arthritis,table(Improved,Sex,Treatment))
multtab<-xtabs(~Improved+Sex+Treatment,data=Arthritis)

margin.table(multtab,1)
margin.table(multtab,2)
margin.table(multtab,3)

# Improved x Treatment 교차셀에 대한 빈도합, 인덱스로 주어지지 않은 Sex에 대해 합산
margin.table(multtab,c(1,3))

# sex x Treatment 조합에 대한 Improved의 세 레벨의 비율, 합
ftable(prop.table(multtab,c(2,3)))
ftable(addmargins(prop.table(multtab,c(2,3)),1))

# ==============================================================================
