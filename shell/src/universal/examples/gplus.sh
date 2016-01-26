#!/bin/bash
exec unicorn -nc "$0" "$@"
!#

import scala.io.Source
import unicorn.json._
import unicorn.bigtable.hbase.HBase
import unicorn.unibase._
import unicorn.unibase.Unibase.{$id, $graph}
import unicorn.graph._

def ego(table: Table, files: String*): Unit = {
  files.foreach { file =>
    val feats = new Array[String](20000)
    Source.fromFile(file + ".featnames").getLines.foreach { line =>
      val feat = line.split(" ", 2)
      feats(feat(0).toInt) = feat(1)
    }

    val docs = collection.mutable.Map[String, JsObject]()
    Source.fromFile(file + ".feat").getLines.foreach { line =>
      val feat = line.split(" ")
      val doc = JsObject(
        $id -> feat(0),
        $graph -> JsObject(
          "follows" -> JsObject()
        )
      )
      for (i <- 1 until feat.length) {
        if (feat(i) == "1") {
          val f = feats(i-1).split(":")
          if (f.length > 1) doc(f(0)) = f(1)
        }
      }
      docs(doc($id)) = doc
    }

    Source.fromFile(file + ".edges").getLines.foreach { line =>
      val edge = line.split(" ")
      if (docs.contains(edge(0))) {
        val doc = docs(edge(0))
        graph(doc)("follows", edge(1)) = JsNull
      }
    }

    docs.toSeq.foreach { case (id, doc) =>
      table.upsert(doc)
    }
  }
}

val db = Unibase(HBase())
db.createTable("gplus")
val table = db("gplus")

ego(table, "../../data/gplus/100129275726588145876")
ego(table, "../../data/gplus/100329698645326486178")
ego(table, "../../data/gplus/100466178325794757407")
ego(table, "../../data/gplus/100500197140377336562")
ego(table, "../../data/gplus/100518419853963396365")
ego(table, "../../data/gplus/100521671383026672718")
ego(table, "../../data/gplus/100535338638690515335")
ego(table, "../../data/gplus/100637660947564674695")
ego(table, "../../data/gplus/100668989009254813743")
ego(table, "../../data/gplus/100715738096376666180")
ego(table, "../../data/gplus/100720409235366385249")
ego(table, "../../data/gplus/100962871525684315897")
ego(table, "../../data/gplus/101130571432010257170")
ego(table, "../../data/gplus/101133961721621664586")
ego(table, "../../data/gplus/101185748996927059931")
ego(table, "../../data/gplus/101263615503715477581")
ego(table, "../../data/gplus/101373961279443806744")
ego(table, "../../data/gplus/101499880233887429402")
ego(table, "../../data/gplus/101541879642294398860")
ego(table, "../../data/gplus/101560853443212199687")
ego(table, "../../data/gplus/101626577406833098387")
ego(table, "../../data/gplus/101848191156408080085")
ego(table, "../../data/gplus/101997124338642780860")
ego(table, "../../data/gplus/102170431816592344972")
ego(table, "../../data/gplus/102340116189726655233")
ego(table, "../../data/gplus/102615863344410467759")
ego(table, "../../data/gplus/102778563580121606331")
ego(table, "../../data/gplus/103236949470535942612")
ego(table, "../../data/gplus/103241736833663734962")
ego(table, "../../data/gplus/103251633033550231172")
ego(table, "../../data/gplus/103338524411980406972")
ego(table, "../../data/gplus/103503116383846951534")
ego(table, "../../data/gplus/103537112468125883734")
ego(table, "../../data/gplus/103752943025677384806")
ego(table, "../../data/gplus/103892332449873403244")
ego(table, "../../data/gplus/104076158580173410325")
ego(table, "../../data/gplus/104105354262797387583")
ego(table, "../../data/gplus/104226133029319075907")
ego(table, "../../data/gplus/104290609881668164623")
ego(table, "../../data/gplus/104607825525972194062")
ego(table, "../../data/gplus/104672614700283598130")
ego(table, "../../data/gplus/104905626100400792399")
ego(table, "../../data/gplus/104917160754181459072")
ego(table, "../../data/gplus/104987932455782713675")
ego(table, "../../data/gplus/105565257978663183206")
ego(table, "../../data/gplus/105646458226420473639")
ego(table, "../../data/gplus/106186407539128840569")
ego(table, "../../data/gplus/106228758905254036967")
ego(table, "../../data/gplus/106328207304735502636")
ego(table, "../../data/gplus/106382433884876652170")
ego(table, "../../data/gplus/106417861423111072106")
ego(table, "../../data/gplus/106724181552911298818")
ego(table, "../../data/gplus/106837574755355833243")
ego(table, "../../data/gplus/107013688749125521109")
ego(table, "../../data/gplus/107040353898400532534")
ego(table, "../../data/gplus/107203023379915799071")
ego(table, "../../data/gplus/107223200089245371832")
ego(table, "../../data/gplus/107296660002634487593")
ego(table, "../../data/gplus/107362628080904735459")
ego(table, "../../data/gplus/107459220492917008623")
ego(table, "../../data/gplus/107489144252174167638")
ego(table, "../../data/gplus/107965826228461029730")
ego(table, "../../data/gplus/108156134340151350951")
ego(table, "../../data/gplus/108404515213153345305")
ego(table, "../../data/gplus/108541235642523883716")
ego(table, "../../data/gplus/108883879052307976051")
ego(table, "../../data/gplus/109130886479781915270")
ego(table, "../../data/gplus/109213135085178239952")
ego(table, "../../data/gplus/109327480479767108490")
ego(table, "../../data/gplus/109342148209917802565")
ego(table, "../../data/gplus/109596373340495798827")
ego(table, "../../data/gplus/109602109099036550366")
ego(table, "../../data/gplus/110232479818136355682")
ego(table, "../../data/gplus/110241952466097562819")
ego(table, "../../data/gplus/110538600381916983600")
ego(table, "../../data/gplus/110581012109008817546")
ego(table, "../../data/gplus/110614416163543421878")
ego(table, "../../data/gplus/110701307803962595019")
ego(table, "../../data/gplus/110739220927723360152")
ego(table, "../../data/gplus/110809308822849680310")
ego(table, "../../data/gplus/110971010308065250763")
ego(table, "../../data/gplus/111048918866742956374")
ego(table, "../../data/gplus/111058843129764709244")
ego(table, "../../data/gplus/111091089527727420853")
ego(table, "../../data/gplus/111213696402662884531")
ego(table, "../../data/gplus/111278293763545982455")
ego(table, "../../data/gplus/112317819390625199896")
ego(table, "../../data/gplus/112463391491520264813")
ego(table, "../../data/gplus/112573107772208475213")
ego(table, "../../data/gplus/112724573277710080670")
ego(table, "../../data/gplus/112737356589974073749")
ego(table, "../../data/gplus/112787435697866537461")
ego(table, "../../data/gplus/113112256846010263985")
ego(table, "../../data/gplus/113122049849685469495")
ego(table, "../../data/gplus/113171096418029011322")
ego(table, "../../data/gplus/113356364521839061717")
ego(table, "../../data/gplus/113455290791279442483")
ego(table, "../../data/gplus/113597493946570654755")
ego(table, "../../data/gplus/113718775944980638561")
ego(table, "../../data/gplus/113799277735885972934")
ego(table, "../../data/gplus/113881433443048137993")
ego(table, "../../data/gplus/114054672576929802335")
ego(table, "../../data/gplus/114104634069486127920")
ego(table, "../../data/gplus/114122960748905067938")
ego(table, "../../data/gplus/114124942936679476879")
ego(table, "../../data/gplus/114147483140782280818")
ego(table, "../../data/gplus/114336431216099933033")
ego(table, "../../data/gplus/115121555137256496805")
ego(table, "../../data/gplus/115273860520983542999")
ego(table, "../../data/gplus/115360471097759949621")
ego(table, "../../data/gplus/115455024457484679647")
ego(table, "../../data/gplus/115516333681138986628")
ego(table, "../../data/gplus/115573545440464933254")
ego(table, "../../data/gplus/115576988435396060952")
ego(table, "../../data/gplus/115625564993990145546")
ego(table, "../../data/gplus/116059998563577101552")
ego(table, "../../data/gplus/116247667398036716276")
ego(table, "../../data/gplus/116315897040732668413")
ego(table, "../../data/gplus/116450966137824114154")
ego(table, "../../data/gplus/116807883656585676940")
ego(table, "../../data/gplus/116825083494890429556")
ego(table, "../../data/gplus/116899029375914044550")
ego(table, "../../data/gplus/116931379084245069738")
ego(table, "../../data/gplus/117412175333096244275")
ego(table, "../../data/gplus/117503822947457399073")
ego(table, "../../data/gplus/117668392750579292609")
ego(table, "../../data/gplus/117734260411963901771")
ego(table, "../../data/gplus/117798157258572080176")
ego(table, "../../data/gplus/117866881767579360121")
ego(table, "../../data/gplus/118107045405823607895")
ego(table, "../../data/gplus/118255645714452180374")
ego(table, "../../data/gplus/118379821279745746467")