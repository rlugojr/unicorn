/*******************************************************************************
 * (C) Copyright 2015 ADP, LLC.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *******************************************************************************/

package unicorn.graph

import org.specs2.mutable._
import org.specs2.specification.BeforeAfterAll
import unicorn.bigtable.accumulo.Accumulo
import unicorn.json._
import unicorn.unibase._

/**
 * @author Haifeng Li
 */
class UnigraphSpec extends Specification with BeforeAfterAll {
  // Make sure running examples one by one.
  // Otherwise, test cases on same columns will fail due to concurrency
  sequential
  val bigtable = Accumulo()
  val db = new Unibase(bigtable)
  val tableName = "unicorn_unigraph_test"

  override def beforeAll = {
    db.createTable(tableName)
  }

  override def afterAll = {
    db.dropTable(tableName)
  }

  "Unigraph" should {
    "travsel" in {
      val bucket = db(tableName)
      1 === 1
    }
  }
}