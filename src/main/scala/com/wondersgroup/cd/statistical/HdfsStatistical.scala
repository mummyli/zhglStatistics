package com.wondersgroup.cd.statistical

import org.apache.spark.sql.{DataFrame, SparkSession}

/**
  * Created by lsj on 2017-6-13.
  */
object HdfsStatistical {

  def CSVStatistical(stsName:String,
                     fileMap:Map[String, String],
                     sparkSQL:String,
                     spark:SparkSession,
                     saveFunc:(DataFrame,String)=>Unit):Unit={

    fileMap.foreach{case (viewName,filepath)=>{
      val objectRDD = spark.read.option("header","true").csv(filepath)
      objectRDD.createOrReplaceTempView(viewName)
    }}

    val result = spark.sql(sparkSQL);

    saveFunc(result,stsName)
  }

}
