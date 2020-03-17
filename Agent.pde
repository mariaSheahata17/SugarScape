import java.lang.Math;

class Agent {
  public static final int NOLIFESPAN = -999;
  private int metabolism;
  private int vision;
  private int sugarLevel;
  private MovementRule movementRule;
  private int age;
  private int lifespan;
  private Square square;
  
  /* initializes a new Agent with the specified values for its 
  *  metabolism, vision, stored sugar, and movement rule.
  *
  */
  public Agent(int metabolism, int vision, int initialSugar, MovementRule m) {
    this.metabolism = metabolism;
    this.vision = vision;
    this.sugarLevel = initialSugar;
    this.movementRule = m;
    age = 0;
    lifespan = NOLIFESPAN;
    square = null;
  }
  
  /* returns the amount of food the agent needs to eat each turn to survive. 
  *
  */
  public int getMetabolism() {
    return metabolism; 
  } 
  
  /* returns the agent's vision radius.
  *
  */
  public int getVision() {
    return vision; 
  } 
  
  /* returns the amount of stored sugar the agent has right now.
  *
  */
  public int getSugarLevel() {
    return sugarLevel; 
  } 
  
  /* returns the Agent's movement rule.
  *
  */
  public MovementRule getMovementRule() {
    return movementRule; 
  } 
  
  /* returns the Agent's age.
  *
  */
  public int getAge() {
    return age; 
  } 
  
  /* sets the Agent's age.
  *
  */
  public void setAge(int howOld) {
    assert(howOld >= 0);
    this.age = howOld; 
  } 
  
  /* returns the Agent's lifespan.
  *
  */
  public int getLifespan() {
    return lifespan; 
  } 
  
  /* sets the Agent's lifespan.
  *
  */
  public void setLifespan(int span) {
    assert(span >= 0);
    this.lifespan = span; 
  } 
  
  /* returns the Square occupied by the Agent.
  *
  */
  public Square getSquare() {
    return square; 
  } 
  
  /* sets the the Square occupied by the Agent.
  *
  */
  public void setSquare(Square s) {
    this.square = s; 
  } 
  
  /* Moves the agent from source to destination. 
  *  If the destination is already occupied, the program should crash with an assertion error
  *  instead, unless the destination is the same as the source.
  *
  */
  public void move(Square source, Square destination) {
    // make sure this agent occupies the source
    assert(this == source.getAgent());
    if (!destination.equals(source)) { 
      assert(destination.getAgent() == null);
      source.setAgent(null);
      destination.setAgent(this);
    }
  } 
  
  /* Reduces the agent's stored sugar level by its metabolic rate, to a minimum value of 0.
  *
  */
  public void step() {
    sugarLevel = Math.max(0, sugarLevel - metabolism); 
    age += 1;
  } 
  
  /* returns true if the agent's stored sugar level is greater than 0, false otherwise. 
  * 
  */
  public boolean isAlive() {
    return (sugarLevel > 0);
  } 
  
  /* The agent eats all the sugar at Square s. 
  *  The agent's sugar level is increased by that amount, and 
  *  the amount of sugar on the square is set to 0.
  *
  */
  public void eat(Square s) {
    sugarLevel += s.getSugar();
    s.setSugar(0);
  } 
  
  /* Two agents are equal only if they're the same agent, 
  *  not just if they have the same properties.
  */
  public boolean equals(Agent other) {
    return this == other;
  }
  
  public void display(int x, int y, int scale) {
    fill(0);
    ellipse(x, y, 3.0*scale/4, 3.0*scale/4);
  }
}

class AgentTester {
  
  public void test() {
    
    // test constructor, accessors
    int metabolism = 3;
    int vision = 2;
    int initialSugar = 4;
    MovementRule m = null;
    Agent a = new Agent(metabolism, vision, initialSugar, m);
    assert(a.isAlive());
    assert(a.getMetabolism() == 3);
    assert(a.getVision() == 2);
    assert(a.getSugarLevel() == 4);
    assert(a.getMovementRule() == null);
    
    // movement
    Square s1 = new Square(5, 9, 10, 10);
    Square s2 = new Square(5, 9, 12, 12);
    s1.setAgent(a);
    a.move(s1, s2);
    assert(s2.getAgent().equals(a));
    
    // eat
    a.eat(s2);
    assert(a.getSugarLevel() == 9);
    
    // test get/set MovementRule
    
    // step
    a.step();
    assert(a.getSugarLevel() == 6);
    a.step();
    a.step();
    a.step();
    assert(a.getSugarLevel() == 0);
    assert(!a.isAlive());
  }
}
