// ==UserScript==
// @name         CF解题数据可视化
// @name:en      codeforces analytics
// @namespace    https://codeforces.com/profile/tongwentao
// @version      1.3.0
// @description  显示某人Codeforces每个难度过了多少题，每个标签占比，喜欢用什么语言过题，有什么题试过了但是没有通过。
// @description:en Analyse Codeforces profiles
// @author       tongwentao
// @match        https://codeforces.com/profile/*
// @icon         data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant        none
// @require https://cdn.jsdelivr.net/npm/echarts@5.4.2/dist/echarts.min.js
// @license MIT
// ==/UserScript==

(function() {
  'use strict';
  function drawChart(res){
    drawChar1(res);
    drawChar2(res);
    drawChar3(res);
    drawChar4(res);
  }

  function drawChar1(res){
      var div='<div class="roundbox userActivityRoundBox borderTopRound borderBottomRound" id="twtschart1" style="height:400px;padding:2em 1em 0 1em;margin-top:1em;"></div>';
      document.getElementById('pageContent').insertAdjacentHTML('beforeend',div);

      var chartDom = document.getElementById('twtschart1');
      var myChart = echarts.init(chartDom);
      var option;
      var key;

      var xData=[];
      var yData=[];
      xData=Object.keys(res.rating);
      for(key in xData){
        if (xData[key] !== 'undefined') {
          yData.push(res.rating[xData[key]]);
        }
      }
      option = {
        title: {
          text: 'Problem Ratings',
          left: 'center'
        },
          tooltip: {
              trigger: 'axis',
              axisPointer: {
                type: 'shadow'
              }
            },
            grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
            },
            xAxis: [
              {
                type: 'category',
                data: xData,
                axisTick: {
                  alignWithLabel: true
                }
              }
            ],
            yAxis: [
              {
                type: 'value'
              }
            ],
            series: [
              {
                name: 'solved',
                type: 'bar',
                barWidth: '60%',
                data: yData
              }
            ]
      };

      option && myChart.setOption(option);

  }
  function drawChar2(res){

    var div='<div class="roundbox userActivityRoundBox borderTopRound borderBottomRound" id="twtschart2" style="height:400px;padding:2em 1em 0 1em;margin-top:1em;"></div>';
    document.getElementById('pageContent').insertAdjacentHTML('beforeend',div);
    var chartDom = document.getElementById('twtschart2');
    var myChart = echarts.init(chartDom);
    var option;
    var data1=[];
    var key;
    for(key in res.tags){
      var tag=res.tags[key];
      data1.push({value:tag,name:key});
    }
    data1.sort(function(nextValue,currentValue){
      if(nextValue.value<currentValue.value)
        return 1;
      else if(nextValue.value>currentValue.value)
        return -1;
      return 0;
    });
    var data2=[];
    for(key in data1){
      data2.push(data1[key].name);
    }
    option = {
      title: {
        text: 'Tags Solved',
        left: 'center'
      },
      tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b} : {c} ({d}%)'
      },
      legend: {
        type: 'scroll',
        orient: 'vertical',
        right: 10,
        top: 20,
        bottom: 20,
        data: data2
      },
      series: [
        {
          name: 'tag',
          type: 'pie',
          radius: '55%',
          center: ['40%', '50%'],
          data: data1,
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }
      ]
    };

    option && myChart.setOption(option);
  }
  function drawChar3(res){
    var div='<div class="roundbox userActivityRoundBox borderTopRound borderBottomRound" id="twtschart3" style="height:400px;padding:2em 1em 0 1em;margin-top:1em;"></div>';
    document.getElementById('pageContent').insertAdjacentHTML('beforeend',div);
    var chartDom = document.getElementById('twtschart3');
    var myChart = echarts.init(chartDom);
    var option;
    var data1=[];
    var key;
    for(key in res.lang){
      var lang=res.lang[key];
      data1.push({value:lang,name:key});
    }
    data1.sort(function(nextValue,currentValue){
      if(nextValue.value<currentValue.value)
        return 1;
      else if(nextValue.value>currentValue.value)
        return -1;
      return 0;
    });
    var data2=[];
    for(key in data1){
      data2.push(data1[key].name);
    }
    option = {
      title: {
        text: 'Programming Language',
        left: 'center'
      },
      tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b} : {c} ({d}%)'
      },
      legend: {
        type: 'scroll',
        orient: 'vertical',
        right: 10,
        top: 20,
        bottom: 20,
        data: data2
      },
      series: [
        {
          name: 'lang',
          type: 'pie',
          radius: '55%',
          center: ['40%', '50%'],
          data: data1,
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }
      ]
    };

    option && myChart.setOption(option);
  }
  function drawChar4(res){
    var div='<div class="roundbox userActivityRoundBox borderTopRound borderBottomRound" id="twtschart4" style="height:auto;padding:2em 1em 0 1em;margin-top:1em;"></div>';
    document.getElementById('pageContent').insertAdjacentHTML('beforeend',div);
    var toAdd1='<h4>Unsolved Problems(total:';
    var toAdd2=')</h4>';
    var key;
    var total=0;
    for(key in res.unsolved){
      var contestId=res.unsolved[key].contestId;
      var problemIndex=res.unsolved[key].problemIndex;
      if(total%5==0)toAdd2+='<br/>';
      total++;
      if(contestId<10000){
        toAdd2+='<a href="'+'https://codeforces.com/problemset/problem/'+contestId+'/'+problemIndex+''+'">'+key+'<\a>'+'&nbsp;';
      }
      else{
        toAdd2+='<a href="'+'https://codeforces.com/problemset/gymProblem/'+contestId+'/'+problemIndex+''+'">'+key+'<\a>'+'&nbsp;';
      }
    }
    document.getElementById('twtschart4').insertAdjacentHTML('beforeend',toAdd1+total+toAdd2);
  }
  var pathname = window.location.pathname;
  var handle = pathname.substring(pathname.lastIndexOf('/') + 1, pathname.length);
  var httpRequest = new XMLHttpRequest();
      httpRequest.open('GET', 'https://codeforces.com/api/user.status?handle='+handle, true);
      httpRequest.send();
      httpRequest.onreadystatechange = function () {
          if (httpRequest.readyState == 4 && httpRequest.status == 200) {
              var json=JSON.parse(httpRequest.responseText);
              var result=json.result;
              var res={rating:{},tags:{},lang:{},unsolved:{}};
              var solved={};
              var key;
              var contestId;
              var problemIndex;
              var problemId;
              for(key in result){
                  if(result[key].verdict==="OK"){
                      var rating=result[key].problem.rating;
                      var tags=result[key].problem.tags;
                      var lang=result[key].programmingLanguage;
                      if(rating in res.rating){
                          res.rating[rating]++;
                      }
                      else{
                          res.rating[rating]=1;
                      }
                      for(var key2 in tags){
                        var tag=tags[key2];
                        if(tag in res.tags){
                          res.tags[tag]++;
                        }
                        else{
                          res.tags[tag]=1;
                        }
                      }
                      if(lang in res.lang){
                        res.lang[lang]++;
                      }else{
                        res.lang[lang]=1;
                      }
                      contestId=result[key].problem.contestId;
                      problemIndex=result[key].problem.index;
                      problemId=contestId+problemIndex;
                      if(problemId in solved){}
                      else{
                        solved[problemId]={contestId:contestId,problemIndex:problemIndex};
                      }
                  }
              }
              for(key in result){
                if(result[key].verdict!=="OK"){
                  contestId=result[key].problem.contestId;
                  problemIndex=result[key].problem.index;
                  problemId=contestId+problemIndex;
                  if(problemId in solved){}
                  else{
                    res.unsolved[problemId]={contestId:contestId,problemIndex:problemIndex};
                  }
                }
              }
              console.log(res);
              drawChart(res);
          }
      };


})();
