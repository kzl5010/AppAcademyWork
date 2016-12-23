function Student (first, last) {
  this.first = first;
  this.last = last;
  this.courses = [];
}

Student.prototype.name = function () {
  return `${this.first} ${this.last}`;
};

Student.prototype.courses = function () {

};

function Course (name, dept, credits, days, timeBlock) {
  this.name = name;
  this.dept = dept;
  this.credits = credits;
  this.students = new Array();
  this.days = days;
  this.timeBlock = timeBlock;
}

Student.prototype.courses = function () {
  return this.courses;
};

Student.prototype.enroll = function (course) {
  for (let i = 0; i < this.courses.length; i++ ){
    if (this.courses[i].conflictsWith(course)) {
      throw "Schedule Conflict";
      }
  }
  if (!(course in this.courses)) {
    this.courses.push(course);
    course.students.push(this.name());
  }
};

Student.prototype.courseLoad = function () {
  let load = {};

  this.courses.forEach(function(course){
    if (course.dept in load) {
      load[course.dept] += course.credits;
    }
    else {
      load[course.dept] = course.credits;
    }
  });
  return load;
};



Course.prototype.addStudent = function (student) {
  student.enroll(this);
};

Course.prototype.conflictsWith = function(course2) {
  if (this.timeBlock !== course2.timeBlock) {
    return false;
  }

  for (let day of this.days) {
    console.log(day);
    if (course2.days.includes(day)) {
      console.log(course2.days);
      console.log(day);
      return true;
    }
  }
};

let s1 = new Student('Ken', 'Lee');
let c1 = new Course('JS', 'CS', 6, ["M", 'F'], 7);
let c2 = new Course('Ruby', 'CS', 6, ["M", 'F'], 7);
// s1.enroll(c1);
// console.log(s1.courses);
// console.log(c1.students);
// console.log(s1.courseLoad());
// console.log(s1.courses);
// console.log(s1.enroll(c2));
console.log(c1.conflictsWith(c2));
// c2.addStudent(s1);
