# RAM-Model-Verification
A verification environment based test bench has been implemented using System Verilog HVL to verify the behaviour of RAM model.
The test bench environment consists of Transaction class, generator, write driver, read driver, write monitor, read monitor, reference model and scoreboard.
The transaction class consists of properties declared as rand variables and a method to display the current values of those properties.
Generator class randomizes the transaction class properties and sends those randomized values to driver through driver class.
Write driver class receives those randomized variables thorugh mailbox from generator class and assign those values to DUV(RAM model) through interface.
Write monitor retrieves those values sent by driver to DUV through the same interface and send those values to reference model through a mailbox.
Read driver receives the actual output, read signals like read_enable, read_data and read_address from DUV and sends it to read monitor through a mailbox. 
Read monitor receives the data from the read driver through mailbox and sends it to reference model and scoreboard for comparision.
Reference model consists of error free behavioural code for DUV. Reference model receives data from write monitor and read monitor and sends the response to scoreboard.
The scoreboard receives data from both reference model and read monitor and performs a comparision between data received from reference model and read monitor. So the scoreboard compares the actual output of DUV and the error free output and gives the result.
