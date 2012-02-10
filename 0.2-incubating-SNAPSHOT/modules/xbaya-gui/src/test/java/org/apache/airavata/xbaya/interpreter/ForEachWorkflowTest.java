/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
*/
package org.apache.airavata.xbaya.interpreter;

import org.apache.airavata.xbaya.XBayaException;
import org.apache.airavata.xbaya.graph.system.InputNode;
import org.apache.airavata.xbaya.interpreter.utils.WorkflowTestUtils;
import org.apache.airavata.xbaya.interpretor.WorkflowInterpreter;
import org.apache.airavata.xbaya.wf.Workflow;
import org.apache.axis2.engine.ListenerManager;
import org.junit.Test;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.UUID;

public class ForEachWorkflowTest {
       @Test
    public void testScheduleDynamically() throws IOException, URISyntaxException, XBayaException {
        URL systemResource = this.getClass().getClassLoader().getSystemResource("SimpleEcho.xwf");
        Workflow workflow = new Workflow(WorkflowTestUtils.readWorkflow(systemResource));
        ListenerManager manager = WorkflowTestUtils.axis2ServiceStarter();
        ((InputNode) workflow.getGraph().getNode("input")).setDefaultValue("1");
        WorkflowInterpreter interpretor = new WorkflowInterpreter(WorkflowTestUtils.getConfiguration(), UUID.randomUUID().toString(),
                workflow, "NA", "NA",true);
        interpretor.scheduleDynamically();
        manager.stop();
    }
}
