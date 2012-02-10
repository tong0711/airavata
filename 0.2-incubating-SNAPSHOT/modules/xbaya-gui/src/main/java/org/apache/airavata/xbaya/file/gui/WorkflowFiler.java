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

package org.apache.airavata.xbaya.file.gui;

import java.io.File;
import java.io.IOException;

import javax.swing.JFileChooser;
import javax.swing.filechooser.FileFilter;

import org.apache.airavata.common.utils.XMLUtil;
import org.apache.airavata.xbaya.XBayaConstants;
import org.apache.airavata.xbaya.XBayaEngine;
import org.apache.airavata.xbaya.component.ComponentException;
import org.apache.airavata.xbaya.file.XBayaPathConstants;
import org.apache.airavata.xbaya.graph.GraphException;
import org.apache.airavata.xbaya.graph.ws.WSGraph;
import org.apache.airavata.xbaya.graph.ws.WSGraphFactory;
import org.apache.airavata.xbaya.gui.ErrorMessages;
import org.apache.airavata.xbaya.wf.Workflow;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xmlpull.infoset.XmlElement;

public class WorkflowFiler {

    private static Logger logger = LoggerFactory.getLogger(WorkflowFiler.class);

    private XBayaEngine engine;

    private JFileChooser graphFileChooser;

    private final FileFilter graphFileFilter = new FileFilter() {

        @Override
        public String getDescription() {
            return "Workflow Files";
        }

        @Override
        public boolean accept(File file) {
            if (file.isDirectory()) {
                return true;
            }
            String name = file.getName();
            if (name.endsWith(XBayaConstants.GRAPH_FILE_SUFFIX)) {
                return true;
            } else if (name.endsWith(XBayaConstants.WORKFLOW_FILE_SUFFIX)) {
                return true;
            }
            return false;
        }
    };

    /**
     * Creates a FileMenu.
     * 
     * @param engine
     *            the XwfClient, which is used to retrieve the current workflow graph.
     */
    public WorkflowFiler(XBayaEngine engine) {
        this.engine = engine;

        this.graphFileChooser = new JFileChooser(XBayaPathConstants.WORKFLOW_DIRECTORY);
        this.graphFileChooser.addChoosableFileFilter(this.graphFileFilter);

    }

    /**
     * Opens a current workflow from the local file.
     */
    public void openWorkflow() {
        Workflow workflow = null;
        workflow = getWorkflow();
        if (null != workflow) {
            this.engine.setWorkflow(workflow);
        }
    }

    /**
     * @param workflow
     * @return
     */
    public Workflow getWorkflow() {
        Workflow workflow = null;
        int returnVal = this.graphFileChooser.showOpenDialog(this.engine.getGUI().getFrame());

        if (returnVal == JFileChooser.APPROVE_OPTION) {
            File file = this.graphFileChooser.getSelectedFile();
            logger.info(file.getPath());

            try {
                String path = file.getPath();

                if (path.endsWith(XBayaConstants.GRAPH_FILE_SUFFIX)) {
                    WSGraph graph = WSGraphFactory.createGraph(file);
                    workflow = Workflow.graphToWorkflow(graph);
                } else {
                    XmlElement workflowElement = XMLUtil.loadXML(file);
                    workflow = new Workflow(workflowElement);
                }

            } catch (IOException e) {
                this.engine.getErrorWindow().error(ErrorMessages.OPEN_FILE_ERROR, e);
            } catch (GraphException e) {
                this.engine.getErrorWindow().error(ErrorMessages.GRAPH_FORMAT_ERROR, e);
            } catch (ComponentException e) {
                this.engine.getErrorWindow().error(ErrorMessages.GRAPH_FORMAT_ERROR, e);
            } catch (RuntimeException e) {
                this.engine.getErrorWindow().error(ErrorMessages.UNEXPECTED_ERROR, e);
            } catch (Error e) {
                this.engine.getErrorWindow().error(ErrorMessages.UNEXPECTED_ERROR, e);
            }
        }
        return workflow;
    }

    /**
     * Saves a current workflow to the local file.
     */
    public void saveWorkflow() {
        int returnVal = this.graphFileChooser.showSaveDialog(this.engine.getGUI().getFrame());
        if (returnVal == JFileChooser.APPROVE_OPTION) {
            File file = this.graphFileChooser.getSelectedFile();
            logger.info(file.getPath());

            // Put ".xwf" at the end of the file name
            String path = file.getPath();
            if (!path.endsWith(XBayaConstants.WORKFLOW_FILE_SUFFIX)) {
                file = new File(path + XBayaConstants.WORKFLOW_FILE_SUFFIX);
            }

            Workflow workflow = this.engine.getWorkflow();
            try {
                XMLUtil.saveXML(workflow.toXML(), file);
            } catch (IOException e) {
                this.engine.getErrorWindow().error(ErrorMessages.WRITE_FILE_ERROR, e);
            } catch (RuntimeException e) {
                this.engine.getErrorWindow().error(ErrorMessages.GRAPH_SAVE_ERROR, e);
            } catch (Error e) {
                this.engine.getErrorWindow().error(ErrorMessages.UNEXPECTED_ERROR, e);
            }
        }
    }

    /**
     * Imports a workflow from the local file to the current workflow.
     */
    public void importWorkflow() {
        int returnVal = this.graphFileChooser.showOpenDialog(this.engine.getGUI().getFrame());
        if (returnVal == JFileChooser.APPROVE_OPTION) {
            File file = this.graphFileChooser.getSelectedFile();

            Workflow workflow = this.engine.getWorkflow();
            try {

                String path = file.getPath();
                Workflow importedWorkflow;
                if (path.endsWith(XBayaConstants.GRAPH_FILE_SUFFIX)) {
                    WSGraph importedGraph = WSGraphFactory.createGraph(file);
                    importedWorkflow = Workflow.graphToWorkflow(importedGraph);
                } else {
                    XmlElement importedWorkflowElement = XMLUtil.loadXML(file);
                    importedWorkflow = new Workflow(importedWorkflowElement);
                }
                workflow.importWorkflow(importedWorkflow);
                this.engine.setWorkflow(workflow);
            } catch (IOException e) {
                this.engine.getErrorWindow().error(ErrorMessages.OPEN_FILE_ERROR, e);
            } catch (GraphException e) {
                this.engine.getErrorWindow().error(ErrorMessages.GRAPH_FORMAT_ERROR, e);
            } catch (ComponentException e) {
                this.engine.getErrorWindow().error(ErrorMessages.GRAPH_FORMAT_ERROR, e);
            } catch (RuntimeException e) {
                this.engine.getErrorWindow().error(ErrorMessages.UNEXPECTED_ERROR, e);
            } catch (Error e) {
                this.engine.getErrorWindow().error(ErrorMessages.UNEXPECTED_ERROR, e);
            }
        }
    }

}