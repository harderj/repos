package main;

import io.IOHandler;
import java.io.IOException;

public class SimpleEngine {

    IOHandler handler;

    public static void main (String[] args) throws IOException
    {
        SimpleEngine engine = new SimpleEngine();
        engine.go(args[0]);
    }

    public SimpleEngine()
    {
        // Empty
    }

    public void go(String command) throws IOException
    {
        this.handler = new IOHandler(command);
        handler.writeLine("Hey you! What's your name: ");
        String name = handler.readLine(1000);
        handler.writeLine("Okay, " + name + "!");
    }
}
