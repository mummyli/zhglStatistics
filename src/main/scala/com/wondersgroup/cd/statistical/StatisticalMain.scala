package com.wondersgroup.cd.statistical

import com.wondersgroup.cd.model.StatisticalXMLModel
import com.wondersgroup.cd.utils.SaveStatisticResult
import org.apache.spark.sql.SparkSession

import scala.io.Source

/**
  * Created by lsj on 2017-6-13.
  */
class StatisticalMain(appName: String) {

  private val sparkSession = SparkSession
    .builder()
    .appName(appName)
    .getOrCreate()


  def start(confile: String) = {
    val statisticalInfo = scala.xml.XML.loadFile(confile)

    var dicMap: Map[String, String] = Map()


    (statisticalInfo \\ "dic").foreach((dic) => dicMap += ((dic \ "dicname").text -> (dic \ "filepath").text))
    initDICView(dicMap, sparkSession)


    (statisticalInfo \\ "entry").foreach(entry => {
      val statisticalXMLModel = fromXML(entry)

      HdfsStatistical.CSVStatistical(
        statisticalXMLModel.stsName,
        statisticalXMLModel.viewMap,
        readSQL("target/scala-2.12/classes/"+statisticalXMLModel.stsSQL),
        sparkSession,
        SaveStatisticResult.saveToOracle)
    })

  }

  //initalize common dic
  def initDICView(dicMap: Map[String, String], spark: SparkSession) = {
    dicMap.foreach { case (dicName, filepath) => {
      val objectRDD = spark.read.option("header", "true").csv(filepath)
      objectRDD.createOrReplaceTempView(dicName)
    }
    }
  }


  def fromXML(node: scala.xml.Node): StatisticalXMLModel =
    new StatisticalXMLModel {

      var dicMap: Map[String, String] = Map()

      (node \\ "view-map").foreach((mapNode) => {
        dicMap += ((mapNode \ "viewname").text -> (mapNode \ "filepath").text)
      })

      override val viewMap: Map[String, String] = dicMap
      override val stsName: String = (node \ "name").text
      override val stsSQL: String = (node \ "sql").text
    }

  def readSQL(sqlfileName: String):String={
    var sqlStr: String = ""
    Source.fromFile(sqlfileName, "UTF8").getLines().foreach((str) => {
      sqlStr += str.toString
      sqlStr += "\n"
    })
    return sqlStr
  }
}
