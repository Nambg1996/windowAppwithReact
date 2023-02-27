import { useEffect, useState } from "react";
import db from "./nedb/items";
import "./App.css";
import { CreateItem } from "./Components/CreateItem";
import { TODOItems } from "./Components/TODOItems";
import $ from "jquery"

function App() {
  /* const [items, setItems] = useState([]);
  const getAllItems = () => {
    db.find({}, (err, docs) => {
      if (!err) {
        setItems(docs);
      }
    });
  }; */

 
const handerRun = (params) => {

  fetch('http://127.0.0.2:3000/run')
  .then(response => {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return response.text();
  })
  .then(data => {
    console.log(data);

    $("#ip_address").text(data)
    // do something with the data
  })
  .catch(error => console.error(error));

}








  return (
    <div className="App">
     <h1 id="ip_address">hello world</h1>
     <button type="button" className="btn btn-primary" onClick={handerRun}>Primary</button>
    </div>
  );
}

export default App;
