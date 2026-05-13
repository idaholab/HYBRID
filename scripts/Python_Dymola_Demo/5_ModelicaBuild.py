from modelica_builder.model import Model

# parse the model file
source_file = 'Output_5/DCMotor.mo'
model = Model(source_file)

# do read and modify the model
# refer to modelica_builder.model.Model class methods to see what's available
name = model.get_name()
model.set_name('New' + name)
model.add_connect('some.component.port_a', 'another.component.port_b')
model.insert_component('MyComponentType', 'myInst',
                        modifications={'arg1': '1234'}, string_comment='my comment',
                        annotations=['my annotation'], insert_index=0)

# save the result
model.save_as('Output_5/NewDCMotor.mo')