# apply 계열 함수 정리

# apply (input : array, output : array)
# lapply (input : list or vector, output : list)
# sapply (input : list or vector, output : vector or array)
# vapply (input : list or vector, output : vector or array)
# tapply (input : list or vector and factor, output : vector or array)
# mapply (input : list or vector, output : vector or array)

# apply(array, 방향, 함수)
# Apply 함수는 행렬의 행 또는 열 방향으로 특정 함수를 적용
# 1: 행, 2: 열

# lapply()
# l: list 
# 입력으로 vector 또는 list 를 받아 list 를 반환
# 데이터 프레임에도 적용 가능

# sapply()
# s: simplify(단순화)
# 리스트 대신 행렬or벡터로 반환
# as.double(lapply(x,func))와 같음 

# vapply(x, func, format)
# 함수결과값의 벡터형태릴 미리지정하고 해당 형태가 아닐 경우 에러발생

# tapply(벡터,그룹화기준,함수)
# 그룹을 인자로 주고(factor형), 그룹별 처리를 함

# mapply(함수, 인자1, 인자2...)
# sapply와 비슷하지만 여러개의 인자를 넘김













