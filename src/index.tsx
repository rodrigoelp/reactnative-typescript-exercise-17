import * as React from "react";
import { AppRegistry, StyleSheet, View, Text, Image } from "react-native";

const styles = StyleSheet.create({
    textStyle: {
        color: "#131313",
        fontWeight: "100",
        textAlign: "center",
        textAlignVertical: "center",
        paddingHorizontal: 16
    },
    mainGreeting: {
        fontSize: 30,
    },
    followUpGreeting: {
        fontSize: 24
    }
});

class AppShell extends React.PureComponent {
    public render() {
        const greetings = "Hello\n\nIt's me...\n\nHello from the other side!\n\nThis code is running in react native from a swift app!";
        return (
            <View style={{ flex: 1, alignItems: "center", justifyContent: "center", paddingTop: 44, backgroundColor: "#ccccff" }}>
                <Image source={{uri:"https://raw.githubusercontent.com/rodrigoelp/reactnative-typescript-exercise-17/master/static/hello.gif", height: 121, width: 192}} />
                <Text style={styles.textStyle}>
                    <Text style={styles.mainGreeting}>
                        Hello...{"\n\n"}
                    </Text>
                    <Text style={styles.followUpGreeting}>
                        It's me,{"\n\n"}

                        I was wondering if Swift and I would like to meet.{"\n\n"}

                        To grow older...{"\n\n"}

                        And mix..{"\n\n"}

                        To build awesome products without people being mean...{"\n\n"}
                    </Text>
                    <Text style={styles.mainGreeting}>
                        Hello from the otherside!!!{"\n\n"}
                    </Text>
                </Text>
            </View>
        );
    }
}

AppRegistry.registerComponent("swiftly", () => AppShell);