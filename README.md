
# Banking Vault Alerting System

## Project Description

The Banking Vault Alerting System is a cutting-edge security solution designed to automate and enhance the security of banking vaults. It is implemented directly into the vault's hardware and is capable of triggering predefined security scenarios to ensure the safety and integrity of the bank's assets. This system revolutionizes the way we protect valuable assets, making security more robust and responsive than ever before.


![WhatsApp Image 2023-01-05 at 11 38 25 PM](https://github.com/Sakr00/Alerting-System-for-Banking-Vault/assets/111249727/d9307f1f-6585-4611-b688-7c005708e017)

# Installation
  Download ISE *VHDL*
# Usage
 -Open the Project in ISE
 -If you failed in opening the project RUN *Bank_Vault.vhd* File
 -Then use the Testing file which Called *Final_test*
   
  ### Manager Scenario
  
 #### External_door_Going_in_scene
  
  - The manager walks towards the external door and authenticates using the Authentication panel beside the external door (FaceIN & HandIN).
  - If authentication is successful, the external door opens, and the manager enters the room with the bank vault.
  - A distance sensor immediately senses the manager's movement and triggers its bit to '1' until the manager passes it.
  
  #### Internal_Vault/Door_scene
  
  - The manager proceeds towards the Vault Door and authenticates using the Authentication panel beside the Vault Door (FaceIN & HandIN).
  - If authentication is successful, the Vault Door opens at a normal speed, and the Counter increments by one.
  - The manager enters the Vault room and passes by a distance sensor after the Vault Door.
  - When this distance sensor triggers, its bit becomes '1' until the manager passes it.
  - Two more distance sensors trigger as the manager proceeds inside.
  - When the manager returns to the Vault Door, the nearby distance sensor triggers, causing the Vault Door to close after 10 seconds.
  
  #### External_door_Going_Out_scene
  
  - The manager approaches the external door to exit the room.
  - As the manager passes the distance sensor near the External Door, it triggers.
  - The External Door closes after 10 seconds from the sensor trigger.
  
  ### Thief Scenario 1 (The door is opened manually)
  
  #### External_door_Going_in_scene
  
  - The thief goes to the external door and creates a hole to gain entry.
  - The thief passes by the distance sensor near the External Door without successful authentication, activating the alarm.
  
  #### Internal_Vault/Door_scene
  
  - The thief proceeds to the Vault's door and manually opens it.
  - Upon entering, the thief triggers a distance sensor connected to the Vault Door, causing it to close faster than normal.
  - Water activates to fill the Vault room, immobilizing the thief.
  - If the ceiling sensor does not sense water after some time, indicating a hole in the room, Soporific Gas activates, rendering the thief immobilized.
  - The manager and the police approach the External Door, where the manager authenticates and presses the reset button to return the system to the normal state.
  - The suction Holes activate to clear the gas for the police to apprehend the immobilized thief.
  
  ### Thief Scenario 2 (The door is opened manually)
  
  #### External_door_Going_in_scene
  
  - The thief goes to the external door and creates a hole to gain entry.
  - The thief passes by the distance sensor near the External Door without successful authentication, activating the alarm.
  
  #### Internal_Vault/Door_scene
  
  - The thief proceeds to the Vault's door and manually opens it.
  - Upon entering, the thief triggers a distance sensor connected to the Vault Door, causing it to close faster than normal.
  - Water activates to fill the Vault room, immobilizing the thief.
  - The ceiling sensor senses the water, indicating no hole in the room.
  - The manager and the police approach the External Door, where the manager authenticates and presses the reset button to return the system to the normal state.
  - The suction Holes activate to clear the water for the police to apprehend the immobilized thief.
  
  ### Thief Scenario 3 (Vault's door is closed, and there is a hole in the vault)
  
  #### External_door_Going_in_scene
  
  - The thief goes to the external door and creates a hole to gain entry.
  - The thief passes by the distance sensor near the External Door without successful authentication, activating the alarm.
  
  #### Internal_Vault/Door_scene
  
  - The thief proceeds to break into the Vault by creating a hole.
  - Upon entering, the thief triggers a distance sensor connected to the Vault Door, while the magnet of the Vault Door is on '1' (indicating it's closed).
  - This triggers the activation of Soporific Gas to fill the Vault room directly, immobilizing the thief.
  - The manager and the police approach the External Door, where the manager authenticates and presses the reset button to return the system to the normal state.
  - The suction Holes activate to clear the gas for the police to apprehend the immobilized thief.


  

# Project Structure

  The VHDL code of this project is structured into three main components:
  
  - **Authentication_Component_In:** This component serves a crucial role in the security system.
  - **Vault_Door:** The Vault Door component is tightly integrated with Authentication_Component_In, and it manages the security states of the vault.
  - **Authentication_Component_Out:** This component plays a role in the security process.
  
  These components are interconnected. Specifically, the output of **Authentication_Component_In** is connected to the input of **Vault_Door**. The VHDL code adheres to an ASM Block chart that has been designed to fulfill the project's requirements and is optimized for code design using states.
  
  The system operates with the following states:
  - **Normal**
  - **Vault_Door1**
  - **Vault_Door2**
  - **Vault_Being_Closed**
  - **Closed_Door_Danger**
  - **Water_0**
  - **Gas_0**
  - **Water_or_Gas_Closed**
  - **Holes_0**
  
  Additionally, the code runs three concurrent processes:
  - **Clock**
  - **Vault**
  - **External_Door**

All processes are synchronous, ensuring coordinated operation.

The Banking Vault Alerting System comprises several key components, each playing a vital role in the security and functionality of the system:

1. **Authentication_Component_In:**
   - Located beside the Vault Door, it has two inputs (**FaceIN & HandIN**).
   - Responsible for the authentication process for opening/closing the Vault's door.
   - Connected to the internal sensors of the vault.

2. **Authentication_Component_Out:**
   - Positioned beside the external door, it has three inputs (**FaceIN & HandIN & Reset**).
   - Responsible for:
     - Opening/closing the External Door.
     - Resetting the System.
     - Opening the Suction Holes.

3. **Vault_Door:**
   - The Vault Door is connected to the Authenticator Component.
   - It has two inputs (**Authenticator & door_speed**).
   - Responsible for indicating the state of the vault door (opened or closed) and adjusts the door speed accordingly.

4. **External_Sensor (exSen):**
   - Responsible for:
     - Opening the door when the sensor's bit is triggered for the first time (indicating the manager's entry).
     - Closing the door when triggered again (indicating the manager's exit).
     - Opening the external door for the manager and then closing it after 10 seconds/clocks.

5. **Counter:**
   - Responsible for counting how many times the vault door has been opened throughout its lifetime use.

6. **Internal_Sensor (InSen):**
   - Responsible for:
     - Detecting movement inside the vault.
     - Closing the Vault's door after the second trigger of the sensor.
     - Connected with the water sensor to detect attacks on the vault.

7. **Clock Process:**
   - Responsible for initiating the system in the "Normal" state.
   - Manages state transitions, changing from the previous state to the current state.

These components work in concert to provide robust security and automation for the banking vault, ensuring the protection of valuable assets.

# Documentation
  **Internal_Door + Vault + Internal_Sensors**
  
  ![WhatsApp Image 2022-12-30 at 7 49 20 PM](https://github.com/Sakr00/Alerting-System-for-Banking-Vault/assets/111249727/650fc4e7-3eae-4712-bf26-9d6bc303d9af)

  
  **External_Door + Sensors **
  
  ![WhatsApp Image 2022-12-30 at 7 15 20 PM](https://github.com/Sakr00/Alerting-System-for-Banking-Vault/assets/111249727/f8db2b5e-50fc-4e73-bdda-801a0e030c1d)




<!-- Add more sections as needed -->

