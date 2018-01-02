import * as React from "react";
import { AppRegistry, View, Text } from "react-native";

class AppShell extends React.PureComponent {
    public render() {
        const greetings = "Greetings from the other side!\nThis code is running in react native from a swift app!";
        return (
            <View style={{ flex: 1, alignItems: "center", justifyContent: "center", paddingTop: 44 }}>
                <Text style={{ fontSize: 30, textAlign: "center", textAlignVertical: "center" }}>
                    {greetings}
                </Text>
            </View>
        );
    }
}

AppRegistry.registerComponent("swiftly", () => AppShell);