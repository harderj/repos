import java.util.Scanner;

public class MyBot {

    private Scanner scan = new Scanner(System.in);

    public void run()
    {
        while (scan.hasNextLine()) {
            String line = scan.nextLine();

            if (line.length() == 0) continue;

            String[] parts = line.split(" ");
            switch (parts[0]) {
                case "settings":
                    // store game settings
                    break;
                case "update":
                    // store game and player updates
                    break;
                case "action":
                    System.out.println("place_move 6 8");
                    break;
                default:
                    // error
            }
        }
    }

    public static void main(String[] args) {
        (new MyBot()).run();
    }
}
