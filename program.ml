type state = int

type input_event = Trigger | Set

type output_event = int

type transition = state * input_event * output_event

type mealy_machine = {
  states: state list;
  inputs: input_event list;
  mutable transitions: transition list;
  mutable current_state: state;
}

let create_machine states inputs initial_state =
  {
    states;
    inputs;
    transitions = [];
    current_state = initial_state;
  }

let add_transition machine transition =
  machine.transitions <- transition :: machine.transitions

let find_transition machine input =
  let rec find_transition_aux = function
    | [] -> failwith "No transition found for the input."
    | (state, event, output) :: rest ->
      if state = machine.current_state && event = input then (output, state)
      else find_transition_aux rest
  in
  find_transition_aux machine.transitions

let trigger_event machine input =
  let (output, new_state) = find_transition machine input in
  machine.current_state <- new_state;
  output

let rec user_interface machines =
  print_endline
    "Vnesite dogodek (Trigger za generiranje števila, Set za spremembo parametrov, Exit za končanje):";
  let user_input = read_line () in
  match user_input with
  | "Trigger" ->
    List.iter
      (fun machine ->
        let output = trigger_event machine Trigger in
        Printf.printf "Generirano število: %d\n" output)
      machines;
    user_interface machines
  | "Set" ->
    print_endline "Izberite avtomat (vnesite številko od 1 do n):";
    let index = read_int () - 1 in
    if index >= 0 && index < List.length machines then (
      let machine = List.nth machines index in
      print_endline "Vnesite novo začetno stanje:";
      let new_initial_state = read_int () in
      print_endline "Vnesite nov korak generiranja:";
      let new_step = read_int () in
      let new_machine =
        create_machine machine.states machine.inputs new_initial_state
      in
      add_transition new_machine (new_initial_state, Trigger, new_step);
      Printf.printf "Avtomat %d posodobljen.\n" (index + 1);
      user_interface (List.mapi (fun i m -> if i = index then new_machine else m) machines)
    ) else (
      print_endline "Neveljavna izbira avtomata.";
      user_interface machines
    )
  | "Exit" | "exit" -> print_endline "Vmesnik zaključen."
  | _ ->
    print_endline "Neveljaven vnos. Poskusite znova.";
    user_interface machines

let () =
  let machine1 = create_machine [0; 1; 2] [Trigger] 0 in
  let machine2 = create_machine [10; 20; 30] [Trigger] 10 in

  add_transition machine1 (0, Trigger, 1);
  add_transition machine2 (10, Trigger, 5);

  user_interface [machine1; machine2]


  let rec user_interface machine =
    print_endline
      "Vnesite dogodek (Trigger za generiranje števila, set za spremembo parametrov, izhod za končanje):";
    let user_input = read_line () in
    match user_input with
    | "Trigger" ->
      let output = trigger_event machine Trigger in
      Printf.printf "Generirano število: %d\n" output;
      user_interface machine
    | "set" | "Set" ->
      print_endline "Vnesite novo začetno stanje:";
      let new_initial_state = read_int () in
      print_endline "Vnesite nov korak generiranja:";
      let new_step = read_int () in
      let new_machine =
        create_machine machine.states machine.inputs machine.transitions
          new_initial_state
      in
      user_interface { new_machine with current_state = new_initial_state; } (* Posodobitev trenutnega stanja *)
    | "izhod" | "Izhod" | "exit" | "Exit" -> print_endline "Vmesnik zaključen."
    | _ ->
      print_endline "Neveljaven vnos. Poskusite znova.";
      user_interface machine
  
  let () =
    let states = [0; 1; 2] in
    let inputs = [Trigger] in
    let transitions =
      [(0, Trigger, 1); (1, Trigger, 2); (2, Trigger, 3); (3, Trigger, 4)]
    in
    let initial_state = 0 in
    let machine = create_machine states inputs transitions initial_state in
  
    user_interface machine
  