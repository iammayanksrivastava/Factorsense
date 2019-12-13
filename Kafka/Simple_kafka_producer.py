from confluent_kafka import Producer

#Call Back method, err and msg parameters, err parameter tells about the
def acked(err, msg):
    if err is not None:
        print("Failed to deliver message: {0}: {1}"
                .format(msg.value(), err.str()))
    else:
        print("Message produced: {0}". format(msg.value()))


p = Producer({'bootstrap.servers': 'ns3080240.ip-145-239-0.eu:9092'})


try:
    for val in xrange(1, 1000):
        p.produce('fs_topic', 'myvalue #{0}'
                    .format(val), callback=acked)
        p.poll(0.5)

except KeyboardInterrupt:
    pass


p.flush(30)
