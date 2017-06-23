package com.wondersgroup.cd.statistical

/**
  * Created by lsj on 2017-6-15.
  */
object StatisticController {

  def main(args: Array[String]): Unit ={

    val DEFAULT_CONFIG="target/scala-2.12/classes/statistical-conf.xml"
    val DEFAULT_APP_NAME = "default app name"


    if(args.length==0){
      new StatisticalMain(DEFAULT_APP_NAME).start(DEFAULT_CONFIG)
    }
    if(args.length==1) {
      new StatisticalMain(args(0)).start(DEFAULT_CONFIG)
    }else{
      new StatisticalMain(args(0)).start(args(1))
    }
  }

}
