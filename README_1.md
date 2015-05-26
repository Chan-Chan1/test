# Smart-Hl7

Smart-Hl7 is a simple ruby library for sending HL7 messages. It makes sending of HL7 messages across multiple hosts very simple. All you need is to provide the HL7 message file, host and the port on which HL7 has been configured. Also it logs every messaging activity under the directory from where the `smart-hl7 --send` command is triggered.
Smart-Hl7 uses a java component `HL7Sender.jar` for sending the HL7 message and receiving the response for the message.
Smart-Hl7 doesn't deal with creating HL7 message components, it inputs the HL7 message file or string itself along with host and port and sends it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smart-hl7'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smart-hl7

## Usage

Type `smart-hl7` command for its command line utilities.

    $ smart-hl7 --send --file '<HL7 message or file path>' --host '<host name>' --port '<port number>'

where

--file - HL7 message file path or the message string itself

--host - the host name or IP address

--port - the port on which HL7 is configured

##### Example :

    $ smart-hl7 --send --file 'E:\Projects\Ruby_App\hl7\hl7_templates\message1.txt' --host '192.2.1.8' --port '12425'

The above command sends the HL7 message (provided the input parameters are valid) and prints

    Sends the HL7 message to the given host and port and logs the response
    The HL7 message log is saved in 'C:/Users/User/hl7_message_logs/message_26_05_2015-11_24_40.log' file

It automatically creates `hl7_message_logs` directory under the current directory (from where the above command is triggered) and saves each messaging activity as a `.log` file.
The log file holds the HL7 message that has been sent and the response that has been received.

Also, it can be required inside ruby script

##### Example :

    require 'smart/hl7'

    str_msg_file = 'E:\Projects\Ruby_App\hl7\hl7_templates\message1.txt'
    str_host = '192.2.1.8'
    num_port = 12425

    HL7::Sender.send(str_msg_file, str_host, num_port)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/smart-hl7/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
