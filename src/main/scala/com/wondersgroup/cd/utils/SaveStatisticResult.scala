package com.wondersgroup.cd.utils

import java.io.FileInputStream
import java.util.Properties

import org.apache.spark.sql.DataFrame

/**
  * Created by lsj on 2017-6-15.
  */
object SaveStatisticResult {

  private val properties = new Properties()

  {
    properties.load(new FileInputStream("target/scala-2.12/classes/jdbc.properties"))
  }

  def saveToOracle(result:DataFrame,tablename:String):Unit={

    result.write
      .format("jdbc")
      .option("url",properties.get("url").toString)
      .option("dbtable",tablename)
      .option("user",properties.get("user").toString)
      .option("password",properties.get("password").toString)
      .save()
  }

  def saveToMySQL(result:DataFrame,tablename:String):Unit={
  }
}
