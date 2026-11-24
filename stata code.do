cd"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta"

use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据"

***描述性分析
summarize 文旅活力指数_熵权法 强度指数_熵权法 多样性指数_熵权法 稳定性指数_熵权法 l2nevpen nonl2nevpen l2fpvpen nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx

***主效应分析
xtset id 年份
xtreg 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, fe vce(cluster id)

***维度分析
//（1）强度
xtreg 强度指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, fe vce(cluster id)
//（2）多样性
xtreg 多样性指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, fe vce(cluster id)
//（3）稳定性
xtreg 稳定性指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, fe vce(cluster id)

***技术分解
xtreg 文旅活力指数_熵权法 l2nevpen nonl2nevpen l2fpvpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, fe vce(cluster id)
test l2nevpen = nonl2nevpen
test l2nevpen = l2fpvpen

***稳健性检验
//剔除疫情年份
keep if inlist(年份,2018,2019,2023,2024)
xtset id 年份
xtreg 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, fe vce(cluster id)

//替换被解释变量权重
xtreg 文旅活力指数_等比例法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, fe vce(cluster id)

xtreg 文旅活力指数_PCA法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, fe vce(cluster id)

//替换解释变量
xtreg 文旅活力指数_PCA法 l2nevnev 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, fe vce(cluster id)

//缩尾
local winsor_vars 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx
winsor2 `winsor_vars', cuts(1 99) by(年份) suffix(_w)
xtreg 文旅活力指数_熵权法_w l2nevpen_w 经济发展水平_w 城镇化率_w 人口规模_w 产业结构_w 移动电话普及率_w 民用汽车拥有量logx_w 等级公路线路里程logx_w 高速公路线路里程公里logx_w 城市公共汽电车运营车辆数logx_w i.年份, fe vce(cluster id)

//剔除直辖市
use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据.dta"
xtset id 年份
xtreg 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份 if !inlist(城市,"北京市","上海市","天津市","重庆市"), fe vce(cluster id)

//剔除省会城市
frame create caps
frame change caps
clear
input str20 城市
"北京市"
"天津市"
"上海市"
"重庆市"
"石家庄市"
"太原市"
"沈阳市"
"长春市"
"哈尔滨市"
"南京市"
"杭州市"
"合肥市"
"福州市"
"南昌市"
"济南市"
"郑州市"
"武汉市"
"长沙市"
"广州市"
"海口市"
"成都市"
"贵阳市"
"昆明市"
"西安市"
"兰州市"
"西宁市"
"南宁市"
"呼和浩特市"
"拉萨市"
"银川市"
"乌鲁木齐市"
end
frame change default
frlink m:1 城市, frame(caps)
gen byte is_cap = !missing(caps)
xtreg 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份 if is_cap==0, fe vce(cluster id)

//解释变量滞后一期
gen Ll2nevpen = L.l2nevpen
xtreg 文旅活力指数_熵权法 Ll2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, fe vce(cluster id)

//解释变量滞后两期
gen L2l2nevpen = L2.l2nevpen
xtreg 文旅活力指数_熵权法 L2l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, fe vce(cluster id)


***门槛效应
//以nevpen作为门槛变量
xi:xthreg 文旅活力指数_熵权法 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, rx(l2nevpen) qx(nevpen) thnum(2) bs(300 300) trim(0.05 0.05) grid(500) vce(cluster id)
*双门槛画图
_matplot e(LR21), columns(1 2) ///
    yline(1, lpattern(dash) lcolor(black) lwidth(medium)) ///
    connect(direct) recast(line) lwidth(medthick) lcolor(navy) ///
    ytitle("LR Statistics") xtitle("First Threshold") legend(off) ///
	ylabel(, nogrid) xlabel(, nogrid) 

_matplot e(LR22), columns(1 2) ///
    yline(1, lpattern(dash) lcolor(black) lwidth(medium)) ///
    connect(direct) recast(line) lwidth(medthick) lcolor(navy) ///
    ytitle("LR Statistics") xtitle("2nd Threshold Parameter") legend(off) ///
	ylabel(, nogrid) xlabel(, nogrid) 

//以等级公路线路里程作为门槛变量
xi:xthreg 文旅活力指数_熵权法 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx i.年份, rx(l2nevpen) qx(等级公路线路里程logx) thnum(2) bs(300 300) trim(0.05 0.05) grid(500) vce(cluster id)
*双门槛画图
_matplot e(LR21), columns(1 2) ///
    yline(1, lpattern(dash) lcolor(black) lwidth(medium)) ///
    connect(direct) recast(line) lwidth(medthick) lcolor(navy) ///
    ytitle("LR Statistics") xtitle("First Threshold") legend(off) ///
	ylabel(, nogrid) xlabel(, nogrid) 

_matplot e(LR22), columns(1 2) ///
    yline(1, lpattern(dash) lcolor(black) lwidth(medium)) ///
    connect(direct) recast(line) lwidth(medthick) lcolor(navy) ///
    ytitle("LR Statistics") xtitle("2nd Threshold Parameter") legend(off) ///
	ylabel(, nogrid) xlabel(, nogrid) 


***空间溢出效应分析
//全局莫兰
use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据.dta"
xtset id 年份
xtmoran 文旅活力指数_熵权法, wname(W01.dta)   //空间逆距离矩阵
xtmoran 文旅活力指数_熵权法, wname(W02.dta)   //逆距离平方矩阵
xtmoran 文旅活力指数_熵权法, wname(W05.dta)   //经济地理权重矩阵
//局部莫兰
xtmoran 文旅活力指数_熵权法, wname(W01.dta) morani(2018 2021 2024) graph symbol()

//LM检验---扩大矩阵   help memory
*(1)W01
clear all
set maxvar 10000    
use W01
spcs2xt W011-W01272, matrix(aaa) time(7)
spatwmat using aaaxt, name(WLM) standardize
clear
use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据.dta"
xtset id 年份
reg 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx
spatdiag, weights(WLM)
*(2)W02
clear all
set maxvar 10000    
use W02
spcs2xt W021-W02272, matrix(aaa) time(7)
spatwmat using aaaxt, name(WLM) standardize
clear
use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据.dta"
xtset id 年份
reg 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx
spatdiag, weights(WLM)
*(3)W05
clear all
set maxvar 10000    
use W05
spcs2xt x1-x272, matrix(aaa) time(7)
spatwmat using aaaxt, name(WLM) standardize
clear
use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据.dta"
xtset id 年份
reg 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx
spatdiag, weights(WLM)

//hausman检验
*(1)W01
use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据.dta"
xtset id 年份
spatwmat using W01.dta, name(SW01) standardize
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, hausman model(sdm) wmat(SW01) 
*(2)W02
use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据.dta"
xtset id 年份
spatwmat using W02.dta, name(SW02) standardize
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, hausman model(sdm) wmat(SW02) 
*(3)W05
use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据.dta"
xtset id 年份
spatwmat using W05.dta, name(SW05) standardize
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, hausman model(sdm) wmat(SW05) 

//LR检验
*(1)W01
use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据.dta"
xtset id 年份
spatwmat using W01.dta, name(SW01) standardize
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, fe model(sdm) wmat(SW01) type(ind)
est store ind
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, fe model(sdm) wmat(SW01) type(time)
est store time
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, fe model(sdm) wmat(SW01) type(both)
est store both
lrtest both ind, df(10)
lrtest both time, df(10)
*(2)W02
use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据.dta"
xtset id 年份
spatwmat using W02.dta, name(SW02) standardize
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, fe model(sdm) wmat(SW02) type(ind)
est store ind
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, fe model(sdm) wmat(SW02) type(time)
est store time
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, fe model(sdm) wmat(SW02) type(both)
est store both
lrtest both ind, df(10)
lrtest both time, df(10)
*(2)W05
use"D:\论文\数据挖掘\自动驾驶\城市活力+实验\城市活力\Writing\调整2\距离下限型空间衰减矩阵_20km步长_dta\保留9个指标面板数据.dta"
xtset id 年份
spatwmat using W05.dta, name(SW05) standardize
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, fe model(sdm) wmat(SW05) type(ind)
est store ind
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, fe model(sdm) wmat(SW05) type(time)
est store time
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, fe model(sdm) wmat(SW05) type(both)
est store both
lrtest both ind, df(10)
lrtest both time, df(10)

//Wald检验
*(1)W01
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, wmat(SW01) model(sdm) fe type(both)
//Wald检验---SAR
test [Wx]l2nevpen=[Wx]经济发展水平=[Wx]城镇化率=[Wx]人口规模=[Wx]产业结构=[Wx]移动电话普及率=[Wx]民用汽车拥有量logx=[Wx]等级公路线路里程logx=[Wx]高速公路线路里程公里logx=[Wx]城市公共汽电车运营车辆数logx=0
//Wald检验---SEM
testnl ([Wx]l2nevpe=-[Spatial]rho*[Main]l2nevpe)([Wx]经济发展水平=-[Spatial]rho*[Main]经济发展水平)([Wx]城镇化率=-[Spatial]rho*[Main]城镇化率)([Wx]人口规模=-[Spatial]rho*[Main]人口规模)([Wx]产业结构=-[Spatial]rho*[Main]产业结构)([Wx]移动电话普及率=-[Spatial]rho*[Main]移动电话普及率)([Wx]民用汽车拥有量logx=-[Spatial]rho*[Main]民用汽车拥有量logx)([Wx]等级公路线路里程logx=-[Spatial]rho*[Main]等级公路线路里程logx)([Wx]高速公路线路里程公里logx=-[Spatial]rho*[Main]高速公路线路里程公里logx)([Wx]城市公共汽电车运营车辆数logx=-[Spatial]rho*[Main]城市公共汽电车运营车辆数logx)
*(2))W02
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, wmat(SW02) model(sdm) fe type(both)
//Wald检验---SAR
test [Wx]l2nevpen=[Wx]经济发展水平=[Wx]城镇化率=[Wx]人口规模=[Wx]产业结构=[Wx]移动电话普及率=[Wx]民用汽车拥有量logx=[Wx]等级公路线路里程logx=[Wx]高速公路线路里程公里logx=[Wx]城市公共汽电车运营车辆数logx=0
//Wald检验---SEM
testnl ([Wx]l2nevpe=-[Spatial]rho*[Main]l2nevpe)([Wx]经济发展水平=-[Spatial]rho*[Main]经济发展水平)([Wx]城镇化率=-[Spatial]rho*[Main]城镇化率)([Wx]人口规模=-[Spatial]rho*[Main]人口规模)([Wx]产业结构=-[Spatial]rho*[Main]产业结构)([Wx]移动电话普及率=-[Spatial]rho*[Main]移动电话普及率)([Wx]民用汽车拥有量logx=-[Spatial]rho*[Main]民用汽车拥有量logx)([Wx]等级公路线路里程logx=-[Spatial]rho*[Main]等级公路线路里程logx)([Wx]高速公路线路里程公里logx=-[Spatial]rho*[Main]高速公路线路里程公里logx)([Wx]城市公共汽电车运营车辆数logx=-[Spatial]rho*[Main]城市公共汽电车运营车辆数logx)
*(3)W05
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, wmat(SW05) model(sdm) fe type(both)
//Wald检验---SAR
test [Wx]l2nevpen=[Wx]经济发展水平=[Wx]城镇化率=[Wx]人口规模=[Wx]产业结构=[Wx]移动电话普及率=[Wx]民用汽车拥有量logx=[Wx]等级公路线路里程logx=[Wx]高速公路线路里程公里logx=[Wx]城市公共汽电车运营车辆数logx=0
//Wald检验---SEM
testnl ([Wx]l2nevpe=-[Spatial]rho*[Main]l2nevpe)([Wx]经济发展水平=-[Spatial]rho*[Main]经济发展水平)([Wx]城镇化率=-[Spatial]rho*[Main]城镇化率)([Wx]人口规模=-[Spatial]rho*[Main]人口规模)([Wx]产业结构=-[Spatial]rho*[Main]产业结构)([Wx]移动电话普及率=-[Spatial]rho*[Main]移动电话普及率)([Wx]民用汽车拥有量logx=-[Spatial]rho*[Main]民用汽车拥有量logx)([Wx]等级公路线路里程logx=-[Spatial]rho*[Main]等级公路线路里程logx)([Wx]高速公路线路里程公里logx=-[Spatial]rho*[Main]高速公路线路里程公里logx)([Wx]城市公共汽电车运营车辆数logx=-[Spatial]rho*[Main]城市公共汽电车运营车辆数logx)

//空间杜宾效应检验
*(1)W01
spatwmat using W01.dta, name(SW01) standardize
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, model(sdm) wmat(SW01) nolog effects type(both) fe vce(cluster id)
*(2)W02
spatwmat using W02.dta, name(SW02) standardize
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, model(sdm) wmat(SW02) nolog effects type(both) fe vce(cluster id)
*(3)W05
spatwmat using W05.dta, name(SW05) standardize
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, model(sdm) wmat(SW05) nolog effects type(both) fe vce(cluster id)


***空间衰减效应分析
*后面40，60，一直到520
spatwmat using W_ge_0020km.dta, name(SW_ge_0020km) standardize
xsmle 文旅活力指数_熵权法 l2nevpen 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx, model(sdm) wmat(SW_ge_0020km) nolog effects type(both) fe vce(cluster id)

***工具变量
*** 工具变量命令(聚类稳健健标准误版)
* ivreghdfe rds age car arr gsp fsr ocp ctr (ldt=iv),absorb(id year) vce(cluster id) first keepsing
* ivreghdfe rds age car arr gsp fsr ocp ctr (ldt=iv),absorb(id year) cluster(id) first keepsing

xtset id 年份
ivreghdfe 文旅活力指数_熵权法 经济发展水平 城镇化率 人口规模 产业结构 移动电话普及率 民用汽车拥有量logx 等级公路线路里程logx 高速公路线路里程公里logx 城市公共汽电车运营车辆数logx (l2nevpen=iv),absorb(id 年份) vce(cluster id) first keepsing endog(l2nevpen)

















