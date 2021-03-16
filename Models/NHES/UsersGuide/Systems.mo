within NHES.UsersGuide;
model Systems "Systems Package"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<div>
<div>
<p>The \"Systems\" package contains the implementation of various processes or sub-systems such as a primary heat source (e.g., nuclear reactor) or an industrial process (e.g., high-temperature steam electrolysis). The implemenation is organized in a standard layout using templates in order to allow interchange between various sub-system models with minimal modifications required by the User.</p>
</div>
</div>
<div>
<div>
<p>Sub-systems are separated into independent packages or categories (e.g., PrimaryHeatSystem). These categorical packages contain individual implementations of specific sub-systems implemented by the User (e.g., IRIS or HTSE industrial process).</p>
</div>
</div>
<div>
<div>
<p>Icon layer refers to the top level GUI. This is shown when a model is used.</p>
</div>
</div>
<div>
<div>
<p>Diagram layer refers to the component specific GUI. This is where models to be used are dragged and dropped.</p>
</div>
</div>
<div>
<div>
<h4><span style=\"color: #005500;\">Use of Templates</span></h4>
</div>
</div>
<div>
<div>
<p>In order to stadardize the implemention of models and allow them to be interchanged the templates assist the User in implementing new models. Initial setup requires some User modifications. When implementing a new category or specific sub-system, follow the directions below carefully. It is highly recommended to look at other sub-systems for examples of how things must be created for each particular model.</p>
</div>
</div>
<div>
<div>
<p><span style=\"text-decoration: underline;\">Create a new category of sub-systems:</span></p>
</div>
</div>
<div>
<div>
<ol>
<li>User \"duplicates\" the SubSystem_Category package into the \"NHES.Systems\" package and give it an appropriate name. For illustration this guide will call it \"NewCategory\".</li>
<li>Replace the Icon of the package with a new one that fits the catergory. Simple gray-scale drawings are recommended. The drawing can be done directly in the icon layer or in the \"Icons\" package and the extended.</li>
<li>Under NewCategory.BaseClasses.
<ul>
<li>Partial_SubSystem
<ul>
<li>Go to text layer to the \"annotation\" at the bottom. Change the default name \"changeMe\" to something appropriate based on the new category (e.g., NewCategory -&gt; NC, PrimaryHeatSystem -&gt; PHS). This name will be used throughout the sub-system category.</li>
<li>On the icon layer change the black text to a name for the category (e.g., Primary Heat System).</li>
<li>Define the base ports required for this category of models.</li>
<li>If the diagram layer size is changed, ensure that the Icon layer remains the same. Go to text view and under the annotation make sure Icon( ... extent={{-100,-100,},{100,100}})</li>
</ul>
</li>
</ul>
<ul>
<li>Record_SubSystem
<ul>
<li>Based on the ports added to the model, include the appropriate nominal and initial condition parameters</li>
</ul>
</li>
</ul>
<ul>
<li>Partial_ControlSystem
<ul>
<li>Add any parameters, models, etc. that will be common to all specific sub-systems. Default is none.</li>
</ul>
</li>
</ul>
<ul>
<li>Partial_EventDriver
<ul>
<li>Add any parameters, models, etc. that will be common to all specific sub-systems. Default is none.</li>
</ul>
</li>
</ul>
<ul>
<li>SignalBus_AcuatorInput
<ul>
<li>Add any actuation/input signals here that are common to all specific sub-systems.</li>
<li>Add reference to each specific sub-system signal bus</li>
</ul>
</li>
</ul>
<ul>
<li>SignalBus_SensorOutput
<ul>
<li>Add any actuation/input signals here that are common to all specific sub-systems.</li>
<li>Add reference to each specific sub-system signal bus</li>
</ul>
</li>
</ul>
</li>
<li>Go to directions for new specific sub-system</li>
</ol>
</div>
</div>
<div>
<div>
<p><span style=\"text-decoration: underline;\">Create a new specific sub-system in existing category:</span></p>
</div>
</div>
<div>
<ol>
<li>If User just created a new category then don't duplicate the SubSystem_Specific package just rename the package else User \"duplicates\" the \"NHES.Templates.SubSystem_Category.SubSystem_Specific\" package into the appropriate sub-system category (e.g., NHES.Systems.PrimaryHeatSystem) and gives it an appropriate name. For illustration this guide will call it \"NewSpecific\".</li>
<li>Under NewCategory.NewSpecific.BaseClasses.
<ul>
<li>Partial_SubSystem
<ul>
<li>Go to text layer to the \"annotation\" at the bottom. Change the default name \"changeMe\" to the same name as used in step one of the the new category direction (e.g., NewCategory -&gt; NC, PrimaryHeatSystem -&gt; PHS). This name will be used throughout the sub-system category.</li>
<li>If the diagram layer size is changed, ensure that the Icon layer remains the same. Go to text view and under the annotation make sure Icon( ... extent={{-100,-100,},{100,100}})</li>
</ul>
</li>
</ul>
<ul>
<li>Record_SubSystem
<ul>
<li>No changes</li>
</ul>
</li>
</ul>
<ul>
<li>Partial_ControlSystem
<ul>
<li>No Changes</li>
</ul>
</li>
</ul>
<ul>
<li>Partial_EventDriver
<ul>
<li>No Changes</li>
</ul>
</li>
</ul>
<ul>
<li>SignalBus_AcuatorInput
<ul>
<li>As actuator/input signals are identified include them in this bus. If there are multiple versions of the specific sub-system, the signal bus will ignore any variables that have not been used.</li>
</ul>
</li>
</ul>
<ul>
<li>SignalBus_SensorOutput
<ul>
<li>As sensor/output signals are identified include them in this bus. If there are multiple versions of the specific sub-system, the signal bus will ignore any variables that have not been used.</li>
</ul>
</li>
</ul>
</li>
<li>The records in the Data package should be used for specific sub-system model calculations, data, sources, etc. Rename Data_Dummy and change the black text on the icon layer to create a visual que for when the model is used.</li>
<li>Rename SubSystem_Dummy, add icon, change the top black \"changeMe\" text for a visual que of the model, and develop the physical model here. Change default name in text annotation to same name as used before (e.g., NC, PHS, etc.). Nominal and initial conditions for the ports should be defined in the extends() clause in the text layer. To change between different data, control systems, and/or event drivers right click and change class. Ensure that the CS and ED are replaceable.</li>
<li>Rename CS_Dummy to CS_IDENTIFYINGNAME. This is where control systems should be developed for the physical models. Change top black \"changeMe\" text for a visual que.</li>
<li>Rename ED_Dummy to ED_IDENTIFYINGNAME. This is where event drivers should be developed for the physical models. Change top black \"changeMe\" text for a visual que.</li>
</ol>
</div>
<p><span style=\"text-decoration: underline;\">Use of Place Holder Models:</span></p>
<div>
<p>The Place Holder Model package contain only the most basic connections of a subsystem category. This is useful if a subsystem is unused as all required high-level connections will be maintained and no dynamics of the model will included. See Exapmles.BaseClasses.PartialFullExample.
</p>
</div>
</html>"));
end Systems;
