package com.wondersgroup.cd.model
import scala.xml.Node

/**
  * Created by lsj on 2017-6-14.
  */
abstract class StatisticalXMLModel {
  val stsName:String
  val viewMap:Map[String,String]
  val stsSQL:String

  def fromXML(node:scala.xml.Node):StatisticalXMLModel=
    new StatisticalXMLModel {

      var dicMap:Map[String, String] = Map()

      (node\\ "view-map").foreach((mapNode)=>{
        dicMap+=((mapNode\"viewname").text->(mapNode\"filepath").text)
      })

      override val viewMap: Map[String, String] = dicMap
      override val stsName: String = (node\ "name").text
      override val stsSQL: String = (node\ "sql").text
    }

}

