import './style.css'
import typescriptLogo from './typescript.svg'
import viteLogo from '/vite.svg'
import { setupCounter } from './counter.ts'

function get() {
    let dogs = document.querySelector('#dogs')!
    return fetch("http://localhost:8002/dogs")
        .then((response) => { 
            console.log(response)
            return response.json().then((data) => {
                console.log(data);
                let li = document.createElement("li")
                li.appendChild(document.createTextNode(data.name))
                dogs.append(li)
            }).catch((err) => {
                console.log(err);
            }) 
        });
}

document.querySelector<HTMLDivElement>('#app')!.innerHTML = `
  <div>
    <h1 id="name">Name A Dog</h1>
    <ul id="dogs">
    </ul>
  </div>
`

let name = document.querySelector('#name')!

name.addEventListener('click', () => get())
